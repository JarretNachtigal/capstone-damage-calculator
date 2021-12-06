class ChampionsController < ApplicationController
  # called by front end to display champions drop-down selector
  def index
    champions = Champion.all
    render json: champions
  end
end
