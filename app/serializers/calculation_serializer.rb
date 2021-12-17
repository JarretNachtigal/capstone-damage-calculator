class CalculationSerializer < ActiveModel::Serializer
  attributes :id, :champion_id_one, :champion_id_two, :ability_id, :output, :champ_one_level, :champ_two_level, :ability_level, :defending_champion_current_hp, :attacking_item_id_one, :attacking_item_id_two, :attacking_item_id_three, :attacking_item_id_four, :attacking_item_id_five, :attacking_item_id_six, :defending_item_id_one, :defending_item_id_two, :defending_item_id_three, :defending_item_id_four, :defending_item_id_five, :defending_item_id_six
end
