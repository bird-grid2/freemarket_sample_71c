class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :get_children_categories, :get_grandchildren_categories]

  require 'payjp'
  before_action :set_card, :set_item, except: [:index, :show]

  def index
    @items = Item.includes([:item_images, :category]).where(buyer_id: nil).order('created_at DESC')
    @ladies = @items.where(category_id: 1..199).limit(3)
    @mens = @items.where(category_id: 200..345).limit(3)
    @appliances = @items.where(category_id: 898..983).limit(3)
    @toys =  @items.where(category_id: 685..797).limit(3)
    @chanel = @items.where(brand: 'シャネル').limit(3)
    @vuitton = @items.where(brand: 'ルイヴィトン').limit(3)
    @supreme = @items.where(brand: 'シュプリーム').limit(3)
    @nike = @items.where(brand: 'ナイキ').limit(3)
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
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
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

  def search
    @keyword = params[:search]
    @items = Item.includes(:item_images).search(@keyword).order('created_at DESC').limit(132)
  end


  def purchase
    if user_signed_in?
      @images = @item.item_images
      @shipping_address = ShippingAddress.where(user_id: current_user.id).first
      @condition = @card.blank? || @shipping_address.blank? || user_signed_in? && current_user.id == @item.seller_id || @item.buyer_id.present?
      #購入ボタンが押せない条件

      unless @card.blank?
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]                      #保管した顧客IDでpayjpから情報取得
        customer = Payjp::Customer.retrieve(@card.customer_token)  
        @default_card_information = customer.cards.retrieve(customer.default_card)
        @card_brand = @default_card_information.brand
        case @card_brand
        when "Visa"
          @card_src = "visa.gif"
        when "JCB"
          @card_src = "jcb.gif"
        when "MasterCard"
          @card_src = "master.gif"
        when "American Express"
          @card_src = "amex.gif"
        end
      end
    else
      redirect_to root_path
    end
  end

  def confirm
    @card = Card.where(user_id: current_user.id).first                             #テーブルからpayjpの顧客IDを検索
    if @card.blank?                                                  #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]                      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_token)      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(customer.default_card)
    end
  end

  def pay
    @card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price,                                         #支払金額を入力
    :customer => @card.customer_token,
    :currency => 'jpy',                                             #日本円
    )
    redirect_to done_item_path                                      #完了画面に移動
  end


  def done
    @sold_item = Item.find(params[:id])
    @sold_item.update_attribute(:buyer_id, current_user.id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :brand, :category_id, :condition_id, :postage_id, :prefecture_id, :preparation_period_id, :price, :shipping_method_id, item_images_attributes: [:image, :_destroy, :id])
  end

  def set_item
    @item =Item.find(params[:id])
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end
  
end