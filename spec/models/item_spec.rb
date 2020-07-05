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
