class LikesController < ApplicationController
  before_action :set_item, except: :index
  before_action :set_item_search_query, only: :index

  def index
    @likes = Like.where(user_id: current_user.id)
  end

  def create
    @like = Like.new(user_id: current_user.id, item_id: @item.id)

    if @like.save
    else
      redirect_to item_path(@item.id)
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, item_id: @item.id)

    if like.destroy
    else
      redirect_to item_path(@item.id)
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
