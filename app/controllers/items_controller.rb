class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :get_children_categories, :get_grandchildren_categories]

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
    @parent_categories = Category.where(ancestry: nil)
    @item = Item.new
    @item.item_images.new
  end

  def get_children_categories
    @children_categories = Category.find(params[:parent_id]).children
  end

  def get_grandchildren_categories
    @grandchildren_categories = Category.find(params[:child_id]).children
  end

  def get_shipping_method
    @get_shipping_methods = ShippingMethod.all
  end

  def create

    @item = Item.new(item_params)
    @item.seller_id = current_user.id

    if @item.save
      redirect_to user_path(current_user.id)
      flash[:notice] = '出品が完了しました！'
    else
      @item.item_images.new
      flash.now[:alert] = '入力内容に誤りがあります。ご確認ください。'
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :brand, :category_id, :condition_id, :postage_id, :prefecture_id, :preparation_period_id, :price, :shipping_method_id, item_images_attributes: [:image, :_destroy, :id])
  end

  def set_item
    @item =Item.find(params[:id])
  end

end
