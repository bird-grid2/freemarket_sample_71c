require 'rails_helper'
describe Item do
  describe '#create' do

    it "全ての項目が存在すれば登録できること" do
      user = create(:user)
      item = build(:item, seller_id: user.id)
      expect(item).to be_valid
    end

    it "item_imagesが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, seller_id: user.id)
      item.item_images = []
      item.valid?
      expect(item.errors[:item_images]).to include("を入力してください")
    end

    it "nameが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, name: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "descriptionが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, description: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end

    it "category_idが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, category_id: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:category_id]).to include()
    end

    it "brandが空の場合でも登録できること" do
      user = create(:user)
      item = build(:item, brand: "", seller_id: user.id)
      expect(item).to be_valid
    end

    it "condition_idが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, condition_id: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "postage_idが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, postage_id: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:postage_id]).to include("を入力してください")
    end

    it "shipping_method_idが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, shipping_method_id: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:shipping_method_id]).to include("を入力してください")
    end

    it "prefecture_idが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, prefecture_id: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "preparation_period_idが空の場合登録できないこと" do      
      user = create(:user)
      item = build(:item, preparation_period_id: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:preparation_period_id]).to include("を入力してください")
    end

    it "priceが空の場合登録できないこと" do
      user = create(:user)
      item = build(:item, price: "", seller_id: user.id)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end
  
  end
end