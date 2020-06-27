class CardsController < ApplicationController

  require "payjp"

  def new
    @card = Card.where(user_id: 1)
    redirect_to action: "show" if @card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      #binding.pry
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      card: params['payjp-token']
      )
      @card = Card.new(user_id: 1, customer_token: customer.id)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "new"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: 1).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_token)
      #binding.pry
      customer.delete
      card.delete
    end

  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: 1).first
    #@card = Card.get_card(current_user.card&.customer_token)
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_token)
      @default_card_information = customer.cards.retrieve(customer.default_card)

      @card_brand = @default_card_information.brand
      case @card_brand
      when "Visa"
        # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
        # (画像として登録されている)Visa.pngを返す
        @card_src = "logo/visa.gif"
      when "JCB"
        @card_src = "logo/jcb.gif"
      when "MasterCard"
        @card_src = "logo/master.gif"
      when "American Express"
        @card_src = "logo/amex.gif"
      when "Diners Club"
        @card_src = "logo/diners.gif"
      when "Discover"
        @card_src = "logo/discover.gif"
      end
    end
  end
end
