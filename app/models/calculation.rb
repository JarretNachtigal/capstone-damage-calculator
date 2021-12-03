class Calculation < ApplicationRecord
  # BASE DAMAGE OF AN ABILITY IS STORED AS (BASE - BASE_SCALING) AND WILL BE CORRECTED
  # DURING RUN. EX. CAIT R AD = 300 AT LVL 1, STORED AS 75 + (225 * ABILITY_LEVEL)
  # THIS ALSO APPLIES TO CHAMPION BASE STATS
  
  # ----------

  # this function will use the keywords field of the ability model to decide
  # what damage fields needs to be returned
  def self.handle_output(ability, champ_one, champ_two, params)
    to_return = decide_method(ability, champ_one, champ_two, params)
    return to_return
  end

  # called by handle_output, decides which ability method to call. replace with something smarter if possible
  def self.decide_method(ability, champ_one, champ_two, params)
    # calls ability methods dynamically. saves like 1000 lines. big move
    return Calculation.send("ability_#{ability.keywords}", ability, champ_one, champ_two, params)
  end

  # ----- CAITLYN -----

  def self.ability_caitlyn_q(ability, champ_one, champ_two, params)
    return Calculation.single_proc(ability, champ_one, champ_two, params)
  end
  # this can call cait passive with extra stuff?
  def self.ability_caitlyn_w(ability, champ_one, champ_two, params)
    return "crit doesnt exist yet, cannot be calculated"
  end
  def self.ability_caitlyn_e(ability, champ_one, champ_two, params)
    return Calculation.single_proc(ability, champ_one, champ_two, params)
  end
  def self.ability_caitlyn_r(ability, champ_one, champ_two, params)
    return Calculation.single_proc(ability, champ_one, champ_two, params)
  end
  def self.ability_caitlyn_passive(ability, champ_one, champ_two, params)
    return "crit doesnt exist yet, cannot be calculated"
  end

  # ----- GAREN -----

  def self.ability_garen_q(ability, champ_one, champ_two, params)
    return Calculation.auto_attack_steroid(ability, champ_one, champ_two, params).to_s
  end

  # this can call cait passive with extra stuff?
  def self.ability_garen_w(ability, champ_one, champ_two, params)
    return "defensive abilities are not implemented"
  end

  def self.ability_garen_e(ability, champ_one, champ_two, params)
    # hard coded, refactor if worth while - attack speed doesnt exist, spins cannot be calculated
    spins = 7 # uses base number of spins for now
    damage = 0 # acc
    # garen e base damage does not scale linearly - has additional scaling with champion level
    additional_base_damage = 0
    level = params["champ_one_level"].to_i
    if level < 10 && level != 1
      additional_base_damage = 0.8 * (level-1)
    else # garen's level is higher than 9
      levels_above_nine = level-9
      additional_base_damage = 0.8 * (level-1) # damage scaling up to level 9
      additional_base_damage += levels_above_nine * 0.2 # damage scaling above level 9
    end
    additional_base_damage = additional_base_damage.round(1) # round to tenth
    ability.base_ad += additional_base_damage # adds champion level scaling to base damage
    spins.times do |n|
      if n < 6
        damage += Calculation.single_proc_ad(ability, champ_one, champ_two, params).to_f # calls single_proc_ad becuase single_proc returns string
      else # armor shreded by 25% after 6 hits
        damage += Calculation.single_proc_ad(ability, champ_one, champ_two, params, 25).to_f # calls single_proc_ad becuase single_proc returns string
      end
    end
    return "#{damage * 1.25} physical damage to nearest, #{damage} physical damage to others"
  end

  def self.ability_garen_r(ability, champ_one, champ_two, params)
    # hard coded, refactor later if worth while
    base = 150 * params["ability_level"]
    percent_missing_health_scaling = 20 + (params["ability_level"] * 5)
    # defending champion current health must be added to calculation model
    # ----- current hp calc here -----
    # return base only for now
    return "#{base} true damage"
  end


  # ----- MULTI-USE -----

  # single instance of damage, auto attack damage included
  def self.auto_attack_steroid(ability, champ_one, champ_two, params)
    # damage stat of the auto attack
    defending_armor = champ_two.base_armor + (champ_two.armor_scaling * params["champ_two_level"])
    # armor stat of defending champion
    attacking_damage = champ_one.base_ad + (champ_one.ad_scaling * params["champ_one_level"])
    # steroided auto damage
    base = ability.base_ad + (ability.base_ad_scaling * params["ability_level"])
    scaling = attacking_damage * ((ability.ad_scaling + (ability.ad_scaling_per_level * params["ability_level"])) / 100)
    pre_mitigation_damage = base + scaling + attacking_damage
    # damage once reduced by armor
    damage_multiplier = 100/(100 + defending_armor)
    # final damage return
    damage = pre_mitigation_damage * damage_multiplier
    return damage.round
  end

  # handle ad and ap method calls for abilities that do a single proc of damage
  def self.single_proc(ability, champ_one, champ_two, params)
    attack_damage = single_proc_ad(ability, champ_one, champ_two, params)
    magic_damage = single_proc_ap(ability, champ_one, champ_two, params)
    return "attack damage: #{attack_damage}, magic damage: #{magic_damage}"
  end

  # single instance of damage, physical, called by single_proc
  def self.single_proc_ad(ability, champ_one, champ_two, params, armor_shred = nil)
    # relevent stats
    defending_armor = champ_two.base_armor + (champ_two.armor_scaling * params["champ_two_level"])
     # reduces armor by armor_shred%
    if armor_shred
      defending_armor = defending_armor * ((100-armor_shred)/100)
    end
    attacking_damage = champ_one.base_ad + (champ_one.ad_scaling * params["champ_one_level"])
    # damage stat of the ability
    base = ability.base_ad + (ability.base_ad_scaling * params["ability_level"])
    scaling = attacking_damage * ((ability.ad_scaling + (ability.ad_scaling_per_level * params["ability_level"])) / 100)
    pre_mitigation_damage = base + scaling
    # armor stat of defending champion
    damage_multiplier = 100/(100 + defending_armor)
    # damage once reduced by armor
    damage = pre_mitigation_damage * damage_multiplier
    # final damage return
    return damage.round
  end

  # single instance of damage, magic, called by single_proc
  def self.single_proc_ap(ability, champ_one, champ_two, params)
    # relevent stats
    defending_mr = champ_two.base_mr + (champ_two.mr_scaling * params["champ_two_level"])
    # items are not implemented yet, no ap on champion
    attacking_damage = 0
    # damage stat of the ability
    base = ability.base_ap + (ability.base_ap_scaling * params["ability_level"])
    scaling = attacking_damage * ((ability.ap_scaling + (ability.ap_scaling_per_level * params["ability_level"])) / 100)
    pre_mitigation_damage = base + scaling
    # armor stat of defending champion
    damage_multiplier = 100/(100 + defending_mr)
    # damage once reduced by armor
    damage = pre_mitigation_damage * damage_multiplier
    # final damage return
    return damage.round
  end
end
