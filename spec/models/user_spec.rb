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
  before do
    # @sns = FactoryBot.build(:User)
  end
  describe 'from_omniauth' do
    it "facebookの情報確認" do
      # auth = { provider: "facebook", uid: "12345678", info: { name: "Tanaka", email: "hoge@hoge.com" }}
      #インスタンスのデータ構造にしないUser.from_omniauth(request)にデータを渡した際にrequest.inf.nameのようにデータへアクセスすることができないため
      # 下記データもダミーデータを作成してましてます。binding.pry で帰ってくるauthのデータを参考にしていただきたいです。
      # こちらのテストはUserモデルのテストのため,uses.rbに記載を推奨します。
                          request = OmniAuth::AuthHash.new({
                            "provider" => "facebookr",
                            "uid" => "123456",
                            "info" => {
                              "name" => "Mock User",
                              "image" => "http://mock_image_url.com",
                              "location" => "",
                              "email" => "mock@example.com",
                              "urls" => {
                                "Twitter" => "https://twitter.com/MockUser1234",
                                "Website" => ""
                              }
                            },
                            "credentials" => {
                              "token" => "mock_credentails_token",
                              "secret" => "mock_credentails_secret"
                            },
                            "extra" => {
                              "raw_info" => {
                                "name" => "Mock User",
                                "id" => "123456",
                                "followers_count" => 0,
                                "friends_count" => 0,
                                "statuses_count" => 0
                              }
                            }
                          })
      user = create(:user) # userを作成
      # sns = create(:sns_credential)
      test = {sns: @sns}
      expect(User.from_omniauth(request)).to eq test
      # 実際にfrom_omniauth(にデータを渡したら、どのような値が返ってくるのかを確かめなくてはいけません。
      # 
      # {user: user, sns: @sns}
    end
  end
end