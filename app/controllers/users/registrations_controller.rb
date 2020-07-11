class Users::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      @sns_id =  session["sns_id"] 
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
  
    @address = @user.build_shipping_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = ShippingAddress.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_shipping_address(@address.attributes)
    if @user.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  protected

  def address_params
    params.require(:shipping_address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :prefecture, :city, :block, :building, :phone_number)
  end
end