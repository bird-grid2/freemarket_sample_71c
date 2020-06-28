require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = build(:user)
  end

  describe "#edit" do
    it "アイテム名が空なら登録できない" do
      user = @user
      edit = build(:item, name: nil)
      edit.valid?
      expect(edit.errors[:name]).to include("を入力してください")
    end
    it "商品説明が空なら登録できない" do
      user = @user
      edit = build(:item, description: nil)
      edit.valid?
      expect(edit.errors[:description]).to include("を入力してください")
    end
    it "販売価格が空なら登録できない" do
      user = @user
      edit = build(:item, price: nil)
      edit.valid?
      expect(edit.errors[:price]).to include("を入力してください")
    end
    
    it "販売価格が全角文字なら登録できない" do
      user = @user
      edit = build(:item, price: "あ")
      edit.valid?
      expect(edit.errors[:price]).to include("は数値で入力してください")
    end
    it "販売価格が半角英文字なら登録できない" do
      user = @user
      edit = build(:item, price: "a")
      edit.valid?
      expect(edit.errors[:price]).to include("は数値で入力してください")
    end
    it "販売価格が全角数字なら登録できない" do
      user = @user
      edit = build(:item, price: "０")
      edit.valid?
      expect(edit.errors[:price]).to include("は数値で入力してください")
    end
    it "販売価格が半角数字なら登録できる" do
      user = @user
      edit = build(:item, price: 1)
      expect(edit).to be_valid
    end
    it "全項目入力したなら登録できる" do
      user = @user
      edit = build(:item)
      expect(edit).to be_valid
    end
  end
end
