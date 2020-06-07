class UsersController < ApplicationController
 
  
  def index
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def notification
  end

  def todo
  end

  def like
  end

  def in_progress
    @item = Item.find[:id]
    @image = Item_image.find[image_parms]
  end

  def completed
  end

  def purchase
  end

  def parchased
  end

  def log_out
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end

    def item_params
      params.require(:item).permit(:name, :description)
    end

    def image_params
      params.require(:image).permit(:image, :item_id)
    end

end
