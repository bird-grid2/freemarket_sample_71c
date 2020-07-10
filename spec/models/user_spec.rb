require 'rails_helper'

describe User do
 
  describe '#create' do
    it "nicknameが空ならNG" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailが空ならNG" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "emailが意図しない形ならNG" do
      user = build(:user, email: "aaagmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    it "emailが重複していたらNG" do
      user1 = create(:user)
      expect(build(:user, email: user1.email)).to_not be_valid
    end
    it "passwordが空ならNG" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwordが8文字よりも短ければNG" do
      user = build(:user, password: "aaaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は8文字以上で入力してください")
    end
    it "first_nameが空ならNG" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end
    it "family_nameが空ならNG" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end
    it "first_name_kanaが空ならNG" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end
    it "family_name_kanaが空ならNG" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end
    it "first_nameが全角以外ならNG" do
      user = build(:user, first_name: "yamada")
      user.valid?
      expect(user.errors[:first_name]).to include("全角で入力して下さい")
    end
    it "family_nameが全角以外ならNG" do
      user = build(:user, family_name: "aya")
      user.valid?
      expect(user.errors[:family_name]).to include("全角で入力して下さい")
    end
    it "first_name_kanaが全角カタカナ以外ならNG" do
      user = build(:user, first_name_kana: "yamada")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("全角カタカナのみで入力して下さい")
    end
    it "family_name_kanaが全角カタカナ以外ならNG" do
      user = build(:user, family_name_kana: "aya")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("全角カタカナのみで入力して下さい")
    end
    it "birthdayが空ならNG" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
    it "全て入力されていればOK" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end

describe User do
  describe 'from_omniauth' do
    it "authにデータが保存されていない場合" do
      auth = OmniAuth::AuthHash.new({ "provider" => "facebook", "uid" => "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }})
      expect{User.from_omniauth(auth)}.to change {SnsCredential.count}.by(1)
    end

    it "authにデータが保存されている場合" do
      sns = create(:sns_credential)
      auth = OmniAuth::AuthHash.new({ "provider" => "facebook", "uid" => "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }})
      expect{User.from_omniauth(auth)}.not_to change {SnsCredential.count}
    end

    it "メールアドレスの返り値を確認" do
      auth = OmniAuth::AuthHash.new({ "provider" => "facebook", "uid" => "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }})
      data = User.from_omniauth(auth)
      expect(data[:user].email).to eq auth.info.email
    end

    it "ニックネームの返り値を確認" do
      auth = OmniAuth::AuthHash.new({ "provider" => "facebook", "uid" => "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }})
      data = User.from_omniauth(auth)
      expect(data[:user].nickname).to eq auth.info.name
    end

    it "プロバイダーの返り値を確認" do
      auth = OmniAuth::AuthHash.new({ "provider" => "facebook", "uid" => "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }})
      data = User.from_omniauth(auth)
      expect(data[:sns].provider).to eq auth.provider
    end

    it "uidの返り値を確認" do
      auth = OmniAuth::AuthHash.new({ "provider" => "facebook", "uid" => "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }})
      data = User.from_omniauth(auth)
      expect(data[:sns].uid).to eq auth.uid
    end
  end
end