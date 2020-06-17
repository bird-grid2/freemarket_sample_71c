class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index

    @items = Item.all

  end
  
  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show

    @item = Item.find(params[:id])
    @category = @item.category

  end

  def new
    @item = Item.new
    @item.item_images.new

    @parent_categories = Category.where(ancestry: nil)
  end

  def get_children_categories
    @children_categories = Category.find(params[:parent_id]).children
  end

  def get_grandchildren_categories
    @grandchildren_categories = Category.find(params[:child_id]).children
  end

  def create
    @item = Item.new
    if @item.save
      redirect_to root_path, notice: '出品が完了しました！'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :price, item_images_attributes: [:src, :_destroy, :id])
  end

  def set_item
    @item =Item.find(params[:id])
  end

end
