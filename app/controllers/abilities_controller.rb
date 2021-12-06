class AbilitiesController < ApplicationController
  # show abilites based on champion selected
  def index
    abilites = Ability.all
    render json: abilities
  end
end
