require 'rails_helper'
describe Item do
  describe '#new' do
    it "customer_tokenがない場合は登録できないこと" do
      card = build(:card, customer_token: "")
      card.valid?
      expect(card.errors[:customer_token]).to include("can't be blank")
    end
  end
end