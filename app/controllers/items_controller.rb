class ItemsController < ApplicationController

  require 'payjp'
  before_action :set_card, :set_item

  def index
  end
  
  def show
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
  
  def show
    # @item = Item.find(params[:id])
    # @category = @item.category
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

  def search
    @keyword = params[:search]
    @items = Item.includes(:item_images).search(@keyword).order('created_at DESC').limit(132)
  end

  private
  
  def item_params
    params.require(:item).premit(:name, :description, :brand, :price, :category_id,item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def purchase
    @item = Item.find(1)
    @images = @item.item_images
    card = Card.where(user_id: 1).first
    @shipping_address = ShippingAddress.where(user_id: 1).first
    @condition = card.blank? || @shipping_address.blank?
    unless card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]                      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_token)  
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
  end

  def confirm
    card = Card.where(user_id: 1).first                             #テーブルからpayjpの顧客IDを検索
    if card.blank?                                                  #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]                      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_token)      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(customer.default_card)
    end
  end

  def pay
    @item = Item.find(1)
    card = Card.where(user_id: 1).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price,                                               #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_token,                               #顧客ID
    :currency => 'jpy',                                             #日本円
    )
    redirect_to done_item_path                                      #完了画面に移動
  end


  def done
    current_user = User.find(1)
    @sold_item = Item.find(1)
    @sold_item.update!(buyer_id: current_user.id)
  end

  private

  def set_card
    @card = Card.where(user_id: 1).first
  end
  def set_item
    @item = Item.find(1)
  end
end
