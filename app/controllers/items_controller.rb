class ItemsController < ApplicationController

  def index
  end
  
  def show
    @item = Item.find(params[:id])
    @category = @item.category
  end

  def new
    @parent_categories = Category.where(ancestry: nil)
  end

  def get_children_categories
    @children_categories = Category.find(params[:parent_id]).children
  end

  def get_grandchildren_categories
    @grandchildren_categories = Category.find(params[:child_id]).children
  end

  def create
    Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:category_id)
  end

end
