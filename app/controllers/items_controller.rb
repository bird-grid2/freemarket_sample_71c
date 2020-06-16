class ItemsController < ApplicationController

  def index

    @items = Item.all

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
    @item = Item.new(item_params)

    if @item.save
      redirect_to user_path(current_user.id), notice: '出品が完了しました！'
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).premit(:name, :description, :brand, :price, :category_id,item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
