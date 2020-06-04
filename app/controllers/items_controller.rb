class ItemsController < ApplicationController

  def index
  end
  
  def show
    @item = Item.find(params[:id])
    @category = Category.find(@item.category_id)
  end

  def new
  end

end
