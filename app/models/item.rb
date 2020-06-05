class Item < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_one :order
  belongs_to :category
  has_many :item_images dependent: :destroy
  has_many :comments dependent: :destroy
  has_many :likes dependent: :destroy
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_period  
end
