class UsersController < ApplicationController
  before_action :set_items
  
  def index
  end

  def show
    @user = User.find(current_user.id)
  end

  def notification
  end

  def todo
  end

  def in_progress
    @image = ItemImage.find_by(params[:item_id])
  end

  def completed
  end

  def purchase
  end

  def purchased
  end

  def log_out
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end

    def set_items
      @item = Item.where(seller_id: current_user)
    end

end
