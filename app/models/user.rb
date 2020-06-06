class User < ApplicationRecord
  has_one :shipping_address, dependent: :destroy
  has_one :card, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true,  uniqueness: true
end
