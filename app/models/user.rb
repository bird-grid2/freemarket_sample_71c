class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday, presence: true,  uniqueness: true
  validates :nickname, :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 7 }
  has_one :shiping_address
end
