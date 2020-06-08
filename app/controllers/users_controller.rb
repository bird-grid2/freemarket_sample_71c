class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def show
  end

  def notification
  end

  def todo
  end

  def like
  end

  def in_progress
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

    def set_items
      @item = Item.find_by(params[:user_id])
    end

end
