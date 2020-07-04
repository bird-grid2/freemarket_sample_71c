require 'rails_helper'
describe Card do
  describe '#new' do
    it "customer_tokenがない場合は登録できないこと" do
      card = build(:card, customer_token: nil)
      card.valid?
      expect(card.errors[:customer_token]).to include("can't be blank")
    end

    it "user_idがない場合は登録できないこと" do
      card = build(:card, user_id: nil)
      card.valid?
      expect(card.errors[:user_id]).to include("can't be blank")
    end

    it "customer_tokenとuser_idがあれば登録できること" do
      card = build(:card)
      expect(card).to be_valid
    end

    it "user_idがあれば登録できること" do
      card = build(:card)
      expect(card).to be_valid
    end

  end
end