class ItemsController < ApplicationController

  require 'payjp'
  
  before_action :set_item, except: [:index, :new, :create, :get_children_categories, :get_grandchildren_categories, :search]
  before_action :set_card, except: [:index, :show, :new, :search]

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
    @category = @item.category
    @user = User.find(@item.seller_id)
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def new
    @item = Item.new
    @item.item_images.new
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

  def destroy

    if @item.destroy 
      redirect_to user_path(current_user.id), notice: '商品の削除に成功しました'
    else
      flash.now[:alert] = '商品の削除に失敗しました'
      render :show
    end
  end

  def search
    @keyword = params[:search]
    @items = Item.includes(:item_images).search(@keyword).order('created_at DESC').limit(132)
  end

  def purchase
    if user_signed_in?
      @images = @item.item_images
      @shipping_address = ShippingAddress.find_by(user_id: current_user.id)
      @condition = @card.blank? || @shipping_address.blank? || user_signed_in? && current_user.id == @item.seller_id || @item.buyer_id.present?
      #購入ボタンが押せない条件

      unless @card.blank?
        Payjp.api_key = Rails.application.credentials.payjp[:payjp_private_key]                      #payjpから情報取得
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
    @card = Card.find_by(user_id: current_user.id)                            #テーブルからpayjpの顧客IDを検索
    if @card.blank?                                                  #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_private_key]                      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_token)      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(customer.default_card)
    end
  end

  def done
    @card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.payjp[:payjp_private_key]
    Payjp::Charge.create(
    :amount => @item.price,                                         #支払金額を入力
    :customer => @card.customer_token,
    :currency => 'jpy',                                             #日本円
    )
    @sold_item = Item.find(params[:id])
    @sold_item.update_attribute(:buyer_id, current_user.id)
  end
  
  def edit
    gon.item = @item
    gon.item_images = @item.item_images
    grandchild_category = @item.category
    child_category = grandchild_category.parent
    parent_category = grandchild_category.parent.parent

    @category_parent_array = []
    Category.where(ancestry: parent_category.ancestry).each do |parent|
      @category_parent_array << parent
    end

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
    
    
    # @item.item_imagse.image_urlをバイナリーデータにしてビューで表示できるようにする
    require 'base64'
    require 'aws-sdk'

    gon.item_images_binary_datas = []
    if Rails.env.production?
      client = Aws::S3::Client.new(
                             region: 'ap-northeast-1',
                             access_key_id: Rails.application.credentials.aws[:access_key_id],
                             secret_access_key: Rails.application.credentials.aws[:secret_access_key],
                             )
      @item.item_images.each do |image|
        binary_data = client.get_object(bucket: 'freemarketsample71c', key: image.image.file.path).body.read
        gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    else
      @item.item_images.each do |image|
        binary_data = File.read(image.image.file.file)
        gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end
  end

  def update
    # 登録済画像のidの配列を生成
    ids = @item.item_images.map{|image| image.id }
    # 登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exist_ids = registered_image_params[:ids].map(&:to_i)

    # 登録済画像が残っていない場合(配列に０が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0

    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @item.update(item_params)

      # 登録済画像のうち削除ボタンをおした画像を削除
      unless ids.length == exist_ids.length
        # 削除する画像のidの配列を生成
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.item_images.find(id).destroy
        end
      end

      # 新規登録画像があればcreate
      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |image|
          @item.item_images.create(image: image, item_id: @item.id)
        end
      end

      flash[:notice] = '編集が完了しました'
      redirect_to item_path(@item), data: {turbolinks: false}

    else
      flash[:alert] = '未入力項目があります'
      redirect_back(fallback_location: root_path)
    end
 
  end

  private
    
    def item_params
      params.require(:item).permit(:name, :description, :brand, :category_id, :condition_id, :postage_id, :prefecture_id, :preparation_period_id, :price, :shipping_method_id, item_images_attributes: [:image, :_destroy, :id])
    end

    def registered_image_params
      params.require(:registered_images_ids).permit({ids: []})
    end
  
    def new_image_params
      params.require(:new_images).permit({images: []})
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def set_card
      @card = Card.find_by(user_id: current_user.id)
    end
    
end
