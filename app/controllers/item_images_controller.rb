class ItemImagesController < ApplicationController
  before_action :set_item
  
  def create
  end

  def new
  end
  
  def destroy
  end

  def edit
  end
  
  def update
  end
  
  private

  def set_items
    @item = Item.find(params[:item_id])
  end

end
