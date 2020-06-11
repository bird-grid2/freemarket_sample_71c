class ItemsController < ApplicationController

  def index
    @items = Item.all.includes([:item_images, :category]).where(buyer: nil).order('created_at DESC')
    @ladies = @items.where(category_id: 1..199).limit(3)
    @mens = @items.where(category_id: 200..345).limit(3)
    @appliances = @items.where(category_id: 898..983).limit(3)
    @toys =  @items.where(category_id: 685..797).limit(3)
    @chanel = @items.where(brand: 'シャネル').limit(3)
    @vuitton = @items.where(brand: 'ルイヴィトン').limit(3)
    @supreme = @items.where(brand: 'シュプリーム').limit(3)
    @nike = @items.where(brand: 'ナイキ').limit(3)
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
    params.require(:item).permit(:category_id)
  end

end
