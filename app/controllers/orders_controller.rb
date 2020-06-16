class OrdersController < ApplicationController





  def pay
    card = Card.where(user_id: 1).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => 13500,                                               #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_token,                                  #顧客ID
    :currency => 'jpy',                                             #日本円
  )
    redirect_to action: 'done'                                      #完了画面に移動
  end


  def done
  end

