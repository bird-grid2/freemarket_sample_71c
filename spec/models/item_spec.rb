require 'rails_helper'

RSpec.describe Item, type: :model do

  describe "#edit" do
    context 'validates'  do
      it "アイテム名が空なら登録できない" do
        edit = build(:item, name: nil)
        edit.valid?
        expect(edit.errors[:name]).to include("を入力してください")
      end
      it "商品説明が空なら登録できない" do
        edit = build(:item, description: nil)
        edit.valid?
        expect(edit.errors[:description]).to include("を入力してください")
      end
      it "販売価格が空なら登録できない" do
        edit = build(:item, price: nil)
        edit.valid?
        expect(edit.errors[:price]).to include("を入力してください")
      end
      it "販売価格が全角文字なら登録できない" do
        edit = build(:item, price: "あ")
        edit.valid?
        expect(edit.errors[:price]).to include("は数値で入力してください")
      end
      it "販売価格が半角英文字なら登録できない" do
        edit = build(:item, price: "a")
        edit.valid?
        expect(edit.errors[:price]).to include("は数値で入力してください")
      end
      it "販売価格が全角数字なら登録できない" do
        edit = build(:item, price: "０")
        edit.valid?
        expect(edit.errors[:price]).to include("は数値で入力してください")
      end
      it "商品状態が空なら登録できない" do
        edit = build(:item, condition_id: nil)
        edit.valid?
        expect(edit.errors[:condition_id]).to include("を入力してください")
      end
      it "送料負担が空なら登録できない" do
        edit = build(:item, postage_id: nil)
        edit.valid?
        expect(edit.errors[:postage_id]).to include("を入力してください")
      end
      it "発送地域が空なら登録できない" do
        edit = build(:item, prefecture_id: nil)
        edit.valid?
        expect(edit.errors[:prefecture_id]).to include("を入力してください")
      end
      it "発送期間が空なら登録できない" do
        edit = build(:item, preparation_period_id: nil)
        edit.valid?
        expect(edit.errors[:preparation_period_id]).to include("を入力してください")
      end
      it "送付方法が空なら登録できない" do
        edit = build(:item, shipping_method_id: nil)
        edit.valid?
        expect(edit.errors[:shipping_method_id]).to include("を入力してください")
      end
      it "カテゴリーが空なら登録できない" do
        edit = build(:item)
        edit[:category_id] = nil
        edit.valid?
        expect(edit.errors[:category_id]).to include("を入力してください")
      end
    end

    context 'submit' do
      it "販売価格が半角数字なら登録できる" do
        user = create(:user)
        edit = build(:item, price: 1, seller_id: user.id)
        expect(edit).to be_valid
      end
      it "全項目入力したなら登録できる" do
        user = create(:user)
        edit = build(:item, seller_id: user.id)
        expect(edit).to be_valid
      end
    end
  end
end
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

    describe '#search' do
      it "itemのnameカラムにkeywordと同じ文字列を含む場合はレコードを取得" do
        keyword = "テスト"
        user = create(:user)
        category = create(:category)
        item = create(:item, user_id: user.id, category_id: category.id)
        item1 = create(:item, name: "テスト", user_id: user.id, category_id: category.id)
        item2 = create(:item, name: "単体テスト", user_id: user.id, category_id: category.id)
        item3 = create(:item, name: "単体テスト3", user_id: user.id, category_id: category.id)
        expect(Item.search(keyword)).to include(item1, item2, item3)
      end

      it "itemのnameカラムにkeywordと同じ文字列を含まない場合はレコードを取得しない" do
        keyword = "キーワード"
        user = create(:user)
        category = create(:category)
        item = create(:item, user_id: user.id, category_id: category.id)
        item1 = create(:item, name: "テスト", user_id: user.id, category_id: category.id)
        item2 = create(:item, name: "単体テスト", user_id: user.id, category_id: category.id)
        item3 = create(:item, name: "単体テスト3", user_id: user.id, category_id: category.id)
        expect(Item.search(keyword)).to be_empty
      end

      it "キーワードがない場合は全てのレコードを取得" do
        keyword = ""
        user = create(:user)
        category = create(:category)
        item = create(:item, user_id: user.id, category_id: category.id)
        item1 = create(:item, name: "テスト", user_id: user.id, category_id: category.id)
        item2 = create(:item, name: "単体テスト", user_id: user.id, category_id: category.id)
        item3 = create(:item, name: "単体テスト3", user_id: user.id, category_id: category.id)
        expect(Item.search(keyword)).to include(item, item1, item2, item3)
      end
    end
  end
