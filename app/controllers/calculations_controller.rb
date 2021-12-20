class CalculationsController < ApplicationController
  def create
    champ_one = Champion.find(params[:champion_id_one])
    champ_two = Champion.find(params[:champion_id_two])
    ability = Ability.find(params[:ability_id])
    attacking_items = []
    defending_items = []
    # items
    if params[:attacking_item_id_one]
      attacking_items << Item.find(params[:attacking_item_id_one])
    end
    if params[:defending_item_id_one]
      defending_items << Item.find(params[:defending_item_id_one])
    end
    if params[:attacking_item_id_two]
      attacking_items << Item.find(params[:attacking_item_id_two])
    end
    if params[:defending_item_id_two]
      defending_items << Item.find(params[:defending_item_id_two])
    end
    if params[:attacking_item_id_three]
      attacking_items << Item.find(params[:attacking_item_id_three])
    end
    if params[:defending_item_id_three]
      defending_items << Item.find(params[:defending_item_id_three])
    end
    if params[:attacking_item_id_four]
      attacking_items << Item.find(params[:attacking_item_id_four])
    end
    if params[:defending_item_id_four]
      defending_items << Item.find(params[:defending_item_id_four])
    end
    if params[:attacking_item_id_five]
      attacking_items << Item.find(params[:attacking_item_id_five])
    end
    if params[:defending_item_id_five]
      defending_items << Item.find(params[:defending_item_id_five])
    end
    if params[:attacking_item_id_six]
      attacking_items << Item.find(params[:attacking_item_id_six])
    end
    if params[:defending_item_id_six]
      defending_items << Item.find(params[:defending_item_id_six])
    end

    # items array, fill with  if Item.find()
    # add items to calculation.new (i think it will be fine even if they are null)
      # default to full hp if not input
    if params[:defending_champion_current_hp]
      hp = params[:defending_champion_current_hp] + Calculation.get_items_hp(defending_items)
    else
      hp = champ_two.base_hp + (champ_two.hp_scaling * params[:champ_two_level].to_f) + Calculation.get_items_hp(defending_items)
    end
    calculation = Calculation.new(
      champion_id_one: params[:champion_id_one],
      champion_id_two: params[:champion_id_two],
      ability_id:  params[:ability_id],
      champ_one_level: params[:champ_one_level],
      champ_two_level: params[:champ_two_level],
      ability_level: params[:ability_level],
      output: Calculation.handle_output(ability, champ_one, champ_two, params, attacking_items, defending_items),
      defending_champion_current_hp: hp,
      attacking_item_id_one: params[:attacking_item_id_one],
      defending_item_id_one: params[:defending_item_id_one],
      attacking_item_id_two: params[:attacking_item_id_two],
      defending_item_id_two: params[:defending_item_id_two],
      attacking_item_id_three: params[:attacking_item_id_three],
      defending_item_id_three: params[:defending_item_id_three],
      attacking_item_id_four: params[:attacking_item_id_four],
      defending_item_id_four: params[:defending_item_id_four],
      attacking_item_id_five: params[:attacking_item_id_five],
      defending_item_id_five: params[:defending_item_id_five],
      attacking_item_id_six: params[:attacking_item_id_six],
      defending_item_id_six: params[:defending_item_id_six],
    )

    if calculation.save
      render json: calculation
    else
      render json: { message: "no" }
    end
  end

  # this needs a caclulation serializer
  def index
    calculations = Calculation.all
    render json: calculations
  end
  # this needs fields updated
  # this will probably be replaced. user will create new calculation with fields filled from
  # the one they selected to edit, and allowed to edit those fields before rerunning create
  def update
    calculation = Calculation.find(params[:id])
    calculation.champion_id_one = params[:champion_id_one] || calculation.champion_id_one
    calculation.champion_id_two = params[:champion_id_two] || calculation.champion_id_two
    calculation.ability_id = params[:ability_id] || calculation.ability_id

    if calculation.save
      render json: calculation
    else
      render json: { message: "no" }
    end
  end

  def show
    calculation = Calculation.find(params[:id])
    render json: calculation
  end

  def destroy
    calculation = Calculation.find(params[:id])
    calculation.destroy
    render json: { message: "destroyed" }
  end
end
