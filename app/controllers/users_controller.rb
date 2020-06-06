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

  def items
    @item = Item.find[:id]
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end

    def item_params
      params.require(:item).permit(:name, :description)
    end

    def image_params
      params.require(:image).permit(:image)
    end

end
