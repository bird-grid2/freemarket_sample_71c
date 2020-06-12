class ItemsController < ApplicationController

  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def destroy
  end

  def edit
  end

  def update
  end

private
  def item_params
    params.require(:item).premit(:name, :description, :brand, :price, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
