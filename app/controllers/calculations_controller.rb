class CalculationsController < ApplicationController
  def create
    calculation = Calculation.new(
      champion_id_one: params[:champion_id_one],
      champion_id_two: params[:champion_id_two],
      ability_id:  params[:ability_id],
    )
    if calculation.save
      render json: calculation
    else
      render json: { message: "no" }
    end
  end

  def index
    calculations = Calculation.all
    render json: calculations
  end

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
