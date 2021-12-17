class CalculationSerializer < ActiveModel::Serializer
  attributes :id, :champion_id_one, :champion_id_two, :ability_id, :output, :champ_one_level, :champ_two_level, :ability_level, :defending_champion_current_hp
end
