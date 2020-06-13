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
    @user = User.new(configure_permitted_parameters)
    if @user.save
      redirect_to '/devise/registrations/new_address'
    else
      reder :new      
    end
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email)
    end
end
