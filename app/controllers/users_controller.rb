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

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end
end
