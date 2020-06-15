class ShippingAddressesController < ApplicationController
  def index
    @shipping_address = ShippingAddress.where(user_id: 1)
  end
end
