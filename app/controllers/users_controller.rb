class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end
end
