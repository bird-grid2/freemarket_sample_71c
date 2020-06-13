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

  def create
    @user = User.new(configure_sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end
end
