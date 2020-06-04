class ItemsController < ApplicationController

  def index
  end
  
  def show
    @item = Item.find(params[:id])
    @category = Category.find(@item.category_id)
  end

  def new
    @parent_categories = Category.where(ancestry: nil)
  end

  def get_children_categories
    @children_categories = Category.find(params[:parent_id]).children
  end

  end

end
