class AbilitiesController < ApplicationController
  # show abilites based on champion selected
  def index
    abilities = Ability.all
    render json: abilities
  end

  def show
    abilities = Ability.where(champion_id: params[:id])
    render json: abilities
  end
end
