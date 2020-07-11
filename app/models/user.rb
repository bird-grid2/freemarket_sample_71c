class User < ApplicationRecord
  has_one :shipping_address, dependent: :destroy
  has_one :card, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :seller_items, class_name: 'Item', :foreign_key => 'seller_id'
  has_many :buyer_items, class_name: 'Item', :foreign_key => 'buyer_id'
  #has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :items, through: :likes

  validates :birthday, presence: true
  validates :nickname, presence: true, uniqueness: true
  
  validates :family_name, :first_name, presence: true,
  format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力して下さい"}

  validates :family_name_kana, :first_name_kana, presence: true,
  format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/, message: "全角カタカナのみで入力して下さい"}
  

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end