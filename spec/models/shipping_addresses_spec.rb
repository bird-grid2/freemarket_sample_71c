require 'rails_helper'

describe ShippingAddress do
  describe '#create' do
    it "post_codeが空ならNG" do
      shippingaddress = build(:shipping_address, post_code: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:post_code]).to include("を入力してください")
    end
    it "post_codeにハイフンがない場合NG" do
      shippingaddress = build(:shipping_address, post_code: "1111111")
      shippingaddress.valid?
      expect(shippingaddress.errors[:post_code]).to include("ハイフンを入れて下さい")
    end
    it "prefectureが空ならNG" do
      shippingaddress = build(:shipping_address, prefecture: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:prefecture]).to include("を入力してください")
    end
    it "cityが空ならNG" do
      shippingaddress = build(:shipping_address, city: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:city]).to include("を入力してください")
    end
    it "blockが空ならNG" do
      shippingaddress = build(:shipping_address, block: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:block]).to include("を入力してください")
    end
    it "phone_numberにハイフンがない場合NG" do
      shippingaddress = build(:shipping_address, phone_number: "08012345678")
      shippingaddress.valid?
      expect(shippingaddress.errors[:phone_number]).to include("ハイフンを入れて下さい")
    end
    it "first_nameが空ならNG" do
      shippingaddress = build(:shipping_address, first_name: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:first_name]).to include("を入力してください")
    end
    it "family_nameが空ならNG" do
      shippingaddress = build(:shipping_address, family_name: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:family_name]).to include("を入力してください")
    end
    it "first_name_kanaが空ならNG" do
      shippingaddress = build(:shipping_address, first_name_kana: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:first_name_kana]).to include("を入力してください")
    end
    it "family_name_kanaが空ならNG" do
      shippingaddress = build(:shipping_address, family_name_kana: nil)
      shippingaddress.valid?
      expect(shippingaddress.errors[:family_name_kana]).to include("を入力してください")
    end
    it "first_nameが全角以外ならNG" do
      shippingaddress = build(:shipping_address, first_name: "yamada")
      shippingaddress.valid?
      expect(shippingaddress.errors[:first_name]).to include("全角で入力して下さい")
    end
    it "family_nameが全角以外ならNG" do
      shippingaddress = build(:shipping_address, family_name: "aya")
      shippingaddress.valid?
      expect(shippingaddress.errors[:family_name]).to include("全角で入力して下さい")
    end
    it "first_name_kanaが全角カタカナ以外ならNG" do
      shippingaddress = build(:shipping_address, first_name_kana: "yamada")
      shippingaddress.valid?
      expect(shippingaddress.errors[:first_name_kana]).to include("全角カタカナのみで入力して下さい")
    end
    it "family_name_kanaが全角カタカナ以外ならNG" do
      shippingaddress = build(:shipping_address, family_name_kana: "aya")
      shippingaddress.valid?
      expect(shippingaddress.errors[:family_name_kana]).to include("全角カタカナのみで入力して下さい")
    end
  end
end