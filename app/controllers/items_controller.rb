class ItemsController < ApplicationController
  before_action :set_image

  def index
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
    @item = Item.new(item_params)

    if @item.save
      redirect_to user_path(current_user.id), notice: '出品が完了しました！'
    else
      render :new
    end
  end

  def destroy
  end

  def edit
    @item = Item.find(params[:id])
  end

  def detail
  end


  private
    
    def item_params
      params.require(:item).permit(:category_id, :name, :description, :price, images_attributes: [:src]).merge(user_id: current_user.id)
    end

    def set_image
      @image = ItemImage.where(params[:Item_id])
    end

end
