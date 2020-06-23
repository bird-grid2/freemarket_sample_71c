class LikesController < ApplicationController
  before_action :set_item, except: :index

  def index
    @likes = Like.where(user_id: current_user.id)
  end

  def create
    @like = Like.new(user_id: current_user.id, item_id: @item.id)

    if @like.save
    else
      flash.now[:alert] = 'いいね！できませんでした'
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, item_id: @item.id)

    if like.destroy
    else
      flash.now[:alert] = 'いいね！を削除できませんでした'
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
