class ItemsController < ApplicationController
  # called by front end to display all items in drop-down selector
  def index
    items = Item.all
    render json: items
  end
end
