class ItemsController < ApplicationController
  # called by front end to display all items
  def index
    items = Item.all
    render json: items
  end
end
