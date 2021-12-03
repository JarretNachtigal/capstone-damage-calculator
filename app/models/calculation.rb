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

  def self.decide_method(ability, champ_one, champ_two, params)
    if ability.keywords == "caitlyn_q"
      return ability_caitlyn_q(ability, champ_one, champ_two, params)
    elsif ability.keywords == "caitlyn_e"
      return ability_caitlyn_e(ability, champ_one, champ_two, params)
    elsif ability.keywords == "caitlyn_w"
      return ability_caitlyn_w(ability, champ_one, champ_two, params)
    elsif ability.keywords == "caitlyn_r"
      return ability_caitlyn_r(ability, champ_one, champ_two, params)
    else
      return 'this is broken you monki'
    end
  end

  # ----- CAITLYN -----

  def self.ability_caitlyn_q(ability, champ_one, champ_two, params)
    return Calculation.single_proc(ability, champ_one, champ_two, params)
  end
  # this can call cait passive with extra stuff?
  def self.ability_caitlyn_w(ability, champ_one, champ_two, params)
    p (ability, champ_one, champ_two, params)
    return "crit doesnt exist yet, cannot be calculated"
  end
  def self.ability_caitlyn_e(ability, champ_one, champ_two, params)
    return Calculation.single_proc(ability, champ_one, champ_two, params)
  end
  def self.ability_caitlyn_r(ability, champ_one, champ_two, params)
    return Calculation.single_proc(ability, champ_one, champ_two, params)
  end
  def self.ability_caitlyn_passive(ability, champ_one, champ_two, params)
    p (ability, champ_one, champ_two, params)
    return "crit doesnt exist yet, cannot be calculated"
  end

  # ----- GAREN -----

  def self.ability_garen_q(ability, champ_one, champ_two, params)
    return Calculation.single_proc_ad(ability, champ_one, champ_two, params).to_s
  end
  # this can call cait passive with extra stuff?
  def self.ability_garen_w(ability, champ_one, champ_two, params)
    p (ability, champ_one, champ_two, params)
    return "defensive abilities are not implemented yet"
  end
  def self.ability_garen_e(ability, champ_one, champ_two, params)
    return Calculation.single_proc_ad(ability, champ_one, champ_two, params).to_s
  end
  def self.ability_garen_r(ability, champ_one, champ_two, params)
    return Calculation.single_proc_ad(ability, champ_one, champ_two, params).to_s
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
  def self.single_proc_ad(ability, champ_one, champ_two, params)
    # relevent stats
    defending_armor = champ_two.base_armor + (champ_two.armor_scaling * params["champ_two_level"])
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
    attacking_damage = champ_one.base_ap + (champ_one.ap_scaling * params["champ_one_level"])
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
