class ItemsController < ApplicationController

  require 'payjp'
  before_action :set_card, :set_item

  def index

  end
  
  def show
    
  end

  def new
  end

  def purchase
    @item = Item.find(1)
    @image = ItemImage.find(1)
    card = Card.where(user_id: 1).first
    @shipping_address = ShippingAddress.where(user_id: 1).first
    @condition = card.blank? || @shipping_address.blank?
    unless card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]                      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_token)  
      @default_card_information = customer.cards.retrieve(customer.default_card)
    end
  end

  def confirm
    card = Card.where(user_id: 1).first                             #テーブルからpayjpの顧客IDを検索
    if card.blank?                                                  #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]                      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_token)      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(customer.default_card)
    end
  end


  private

  def set_card
    @card = Card.where(user_id: 1).first
  end
  def set_item
    @item = Item.find(1)
  end
end
