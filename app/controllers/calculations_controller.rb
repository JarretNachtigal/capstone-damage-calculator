class CalculationsController < ApplicationController
  def create
    champ_one = Champion.find(params[:champion_id_one])
    champ_two = Champion.find(params[:champion_id_two])
    ability = Ability.find(params[:ability_id])
    calculation = Calculation.new(
      champion_id_one: params[:champion_id_one],
      champion_id_two: params[:champion_id_two],
      ability_id:  params[:ability_id],
      champ_one_level: params[:champ_one_level],
      champ_two_level: params[:champ_two_level],
      ability_level: params[:ability_level],
      output: Calculation.handle_output(ability, champ_one, champ_two, params)
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
