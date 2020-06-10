class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true,  uniqueness: true

  has_many :saler_items, class_name: 'Item', :foreign_key => 'saler_id'
  has_many :buyer_items, class_name: 'Item', :foreign_key => 'buyer_id'
end
