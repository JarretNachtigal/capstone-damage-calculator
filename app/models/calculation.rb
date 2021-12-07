class Calculation < ApplicationRecord
  # BASE DAMAGE OF AN ABILITY IS STORED AS (BASE - BASE_SCALING) AND WILL BE CORRECTED
  # DURING RUN. EX. CAIT R AD = 300 AT LVL 1, STORED AS 75 + (225 * ABILITY_LEVEL)
  # THIS ALSO APPLIES TO CHAMPION BASE STATS
  
  # ----------

  # this function will use the keywords field of the ability model to decide
  # what damage fields needs to be returned
  def self.handle_output(ability, champ_one, champ_two, params)
    # initialize class variables to be used in calculation
    init_fields(ability, champ_one, champ_two, params)
    # chain start
    to_return = decide_method
    # this does to output field in calculation table
    return to_return
  end

  # called by handle_output, decides which ability method to call. replace with something smarter if possible
  def self.decide_method
    # calls ability methods dynamically. saves like 1000 lines. big move
    return Calculation.send("ability_#{@ability.keywords}")
  end

  def self.init_fields(ability,champ_one,champ_two, params)
    # refactor again to implement items with method calls
    @champ_one_ad = champ_one.base_ad + (champ_one.ad_scaling * params["champ_one_level"].to_f)
    # this needs items
    @champ_one_ap = 0
    # this one uses champion base stats
    @champ_two_max_hp = champ_two.base_hp + (champ_two.hp_scaling * params["champ_two_level"].to_f)
    # this one uses input from user
    if params["defending_champion_current_hp"]
      @champ_two_current_hp = params["defending_champion_current_hp"]
    else
      @champ_two_current_hp = @champ_two_max_hp
    end
    # defending champion defensive stats
    @champ_two_mr = champ_two.base_mr + (champ_two.mr_scaling * params["champ_two_level"])
    @champ_two_armor = champ_two.base_armor + (champ_two.armor_scaling * params["champ_two_level"])
    @mr_damage_multiplier = 100/(100 + champ_two.base_mr + (champ_two.mr_scaling * params["champ_two_level"]))
    # ability base damages (no ad or ap scaling from champion or item stats)
    @ability_base_ad = ability.base_ad + (ability.base_ad_scaling * params["ability_level"])
    @ability_base_ap = ability.base_ap + (ability.base_ap_scaling * params["ability_level"])
    # ability % scaling (this is the %, not the % of the champions stat)
    @ability_ad_scaling = (ability.ad_scaling + (ability.ad_scaling_per_level * params["ability_level"])) / 100
    @ability_ap_scaling = (ability.ap_scaling + (ability.ap_scaling_per_level * params["ability_level"])) / 100
    # extra stuff as they are needed for specific calculations
    @ability_level = params["ability_level"]
    @ability = ability
    @crit_damage_multiplier = champ_one.crit_damage_multiplier
    @champ_one_level = params["champ_one_level"]
  end

  # ----- CAITLYN -----

  def self.ability_caitlyn_q
    return Calculation.single_proc
  end
  # this can call cait_passive
  def self.ability_caitlyn_w
    # correct data for passive damage
    passive = Ability.find(7) # THIS NUMBER MIGHT CHANGE IF I RESEED THE DB -----------------------
    passive_damage = Calculation.ability_caitlyn_passive(passive)
    passive_damage = passive_damage.split(' ')
    passive_damage = passive_damage[0].to_f
    w_damage = Calculation.single_proc_ad()
    damage = passive_damage + w_damage
    return "#{w_damage.round} from trap, #{passive_damage.round} from headshot, #{damage.round} total"
  end
  def self.ability_caitlyn_e
    return Calculation.single_proc
  end
  def self.ability_caitlyn_r
    return Calculation.single_proc
  end
  def self.ability_caitlyn_passive(ability = @ability)
    # damage from normal aa
    base_aa_damage = @champ_one_ad
    # passive level
    passive_level = 0
    if @champ_one_level < 7
      passive_level = 1
    elsif @champ_one_level < 13
      passive_level = 2
    else
      passive_level = 3
    end
    # damage from passive level scaling
    base_ad_scaling_damage = ability.base_ad + (ability.base_ad_scaling * passive_level)
    # damage from crit scaling and infinity edge once it exists
    crit_scaling_damage = 0.5 * (62.5 * @crit_damage_multiplier) # 0.5 hard coded as crit chance
    # damage before armor
    pre_mitigation_damage = (@champ_one_ad + base_ad_scaling_damage + crit_scaling_damage).round
    # damage once reduced by armor
    armor_damage_multiplier = 100/(100 + champ_two.base_armor + (champ_two.armor_scaling * params["champ_two_level"]))
    damage = pre_mitigation_damage * armor_damage_multiplier
    # final damage return
    return "#{damage.round} physical damage (without critical hit)"
  end

  # ----- GAREN -----

  def self.ability_garen_q
    return Calculation.auto_attack_steroid
  end

  def self.ability_garen_w
    return "defensive abilities are not implemented"
  end

  def self.ability_garen_e
    # hard coded, refactor if worth while - attack speed doesnt exist, spins cannot be calculated
    spins = 7 # uses base number of spins for now
    damage = 0 # acc
    nearest_enemy_damage = 0 # acc of nearest enemy damage
    # garen e base damage does not scale linearly - has additional scaling with champion level
    additional_base_damage = 0
    if @champ_one_level < 10 && @champ_one_level != 1
      additional_base_damage = 0.8 * (@champ_one_level-1)
    else # garen's level is higher than 9
      levels_above_nine = @champ_one_level-9
      additional_base_damage = 0.8 * (@champ_one_level-1) # damage scaling up to level 9
      additional_base_damage += levels_above_nine * 0.2 # damage scaling above level 9
    end
    additional_base_damage = additional_base_damage.round(1) # round to tenth
    @ability_base_ad += additional_base_damage # adds champion level scaling to base damage
    spins.times do |n|
      if n < 6
        damage += Calculation.single_proc_ad.to_f # calls single_proc_ad becuase single_proc returns string
        @ability_base_ad *= 1.25
        @ability_ad_scaling *= 1.25
        nearest_enemy_damage += Calculation.single_proc_ad.to_f
        @ability_base_ad /= 1.25
        @ability_ad_scaling /= 1.25
      else # armor shreded by 25% after 6 hits
        damage += Calculation.single_proc_ad(25).to_f # calls single_proc_ad becuase single_proc returns string
        @ability_base_ad *= 1.25
        @ability_ad_scaling *= 1.25
        nearest_enemy_damage += Calculation.single_proc_ad(25).to_f
        @ability_base_ad /= 1.25
        @ability_ad_scaling /= 1.25
      end
    end
    return "#{nearest_enemy_damage} physical damage to nearest, #{damage} physical damage to others"
  end

  def self.ability_garen_r
    # hard coded, refactor later if worth while
    # % missing hp scaling by R level
    percent_missing_health_scaling = (@ability.ad_scaling + @ability_level * @ability.ad_scaling_per_level.to_f)/100.0
    # defending champion current health must be added to calculation model
    # ----- hp calc here -----
    missing_hp = @champ_two_max_hp - @champ_two_current_hp
    missing_hp_damage = missing_hp * percent_missing_health_scaling
    # final
    full_damage = (@ability_base_ad + missing_hp_damage).round
    return "#{full_damage} true damage"
  end


  # ----- MULTI-USE -----

  # single instance of damage, auto attack damage included
  def self.auto_attack_steroid
    # ability scaling based on champ ad
    scaling = @champ_one_ad * ((@ability.ad_scaling + (@ability.ad_scaling_per_level * @ability_level)) / 100)
    # full damage stat before reduction
    pre_mitigation_damage = @ability_base_ad + scaling + @champ_one_ad # ability base damage + ability scaling damage + auto attack damage
    # damage multiplier based on defending armor
    armor_damage_multiplier = 100/(100 + @champ_two_armor)
    # damage once reduced by armor
    damage = pre_mitigation_damage * armor_damage_multiplier
    # final damage return
    return damage.round
  end

  # handle ad and ap method calls for abilities that do a single proc of damage with mixed scaling
  def self.single_proc
    attack_damage = single_proc_ad
    magic_damage = single_proc_ap
    return "attack damage: #{attack_damage}, magic damage: #{magic_damage}"
  end

  # single instance of damage, physical, called by single_proc
  def self.single_proc_ad(armor_shred = nil)
     # reduces armor by armor_shred%
    if armor_shred
      @champ_two_armor = @champ_two_armor * ((100-armor_shred)/100)
    end
    # full damage stat before reduction
    scaling_damage = @champ_one_ad * @ability_ad_scaling
    pre_mitigation_damage = @ability_base_ad + scaling_damage
    # damage multiplier based on defending armor
    armor_damage_multiplier = 100/(100 + @champ_two_armor)
    # damage once reduced by armor
    damage = pre_mitigation_damage * armor_damage_multiplier
    # final damage return
    return damage.round
  end

  # single instance of damage, magic, called by single_proc
  def self.single_proc_ap
    # full damage stat before reduction
    scaling_damage = @champ_one_ap * @ability_ap_scaling
    # damage before reduction
    pre_mitigation_damage = @ability_base_ap + scaling_damage
    # damage multiplier based on defending mr
    mr_damage_multiplier = 100/(100 + @champ_two_mr)
    # damage once reduced by mr
    damage = pre_mitigation_damage * mr_damage_multiplier
    # final damage return
    return damage.round
  end
end
