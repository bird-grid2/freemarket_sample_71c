class UsersController < ApplicationController

  def index
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
  params.require(:user).permit(:nickname, :email)
  end
end