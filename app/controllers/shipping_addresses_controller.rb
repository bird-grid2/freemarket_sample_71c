class ShippingAddressesController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new(family_name: params[:family_name])
  end
end
