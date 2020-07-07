require 'rails_helper'
  describe Item do
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