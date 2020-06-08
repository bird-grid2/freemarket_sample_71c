class UsersController < ApplicationController
  before_action :authenticate_user!
  

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path
    else
      render :new
    end
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
