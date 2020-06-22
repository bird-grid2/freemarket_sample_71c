class ItemsController < ApplicationController
  before_action :set_image

  def index
  end
  
  def show
    @item = Item.find(params[:id])
    @category = @item.category
    @user = User.find(@item.user_id)
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
      redirect_to root_path, notice: '出品が完了しました！'
    else
      render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def edit
    @item = Item.find(params[:id])
    gon.item = @item
    gon.item_images = @item.item_images

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
        binary_data = client.get_object(bucket: 'freemarket-sample-71c', key: image.image.file.path).body.read
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
    @item = Item.find(params[:id])

    if @item.update(registered_image_params)
      flash[:notice] = '編集が完了しました'
      redirect_to item_path(@item), data: {turbolinks: false}

    else
      flash[:alert] = '未入力項目があります'
      redirect_back(fallback_location: root_path)
    end
  end

  private
    
    def item_params
      params.require(:item).permit(:name, :description, :brand, :price, item_images_attributes: [:id, :image, :_destroy])
    end

    def set_image
      @image = ItemImage.where(params[:Item_id])
    end

    def registered_image_params
      params.require(:item).permit(:name, :description, :brand, :price, item_images_attributes: {})
    end


end
