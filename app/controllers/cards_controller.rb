class CardsController < ApplicationController

  require "payjp"

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if @card.exists?
  end

  def pay                                                  #payjpとCardのデータベース作成を実施。
    Payjp.api_key = Rails.application.credentials.payjp[:payjp_private_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト',
      card: params['payjp-token']
      )
      @card = Card.new(user_id: current_user.id, customer_token: customer.id)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "new"
      end
    end
  end

  def delete                                                #PayjpとCardデータベースを削除
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_private_key]
      customer = Payjp::Customer.retrieve(card.customer_token)
      customer.delete
      card.delete
    end

  end

  def show                                                   #Cardのデータpayjpに送り情報を取り出す
    card = Card.where(user_id: current_user.id).first
    #@card = Card.get_card(current_user.card&.customer_token) #ログイン機能マージ後に実装
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_private_key]
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
