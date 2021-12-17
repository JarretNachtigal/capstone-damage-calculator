class ChampionSerializer < ActiveModel::Serializer
  has_many :abilities
  attributes :id, :name, :description, :base_hp, :base_ad, :base_mr, :base_armor, :hp_scaling, :ad_scaling, :mr_scaling, :armor_scaling, :crit_damage_multiplier, :champion_abilities

  def champion_abilities
    abilities = Ability.where(champion_id: :id)
  end
end
