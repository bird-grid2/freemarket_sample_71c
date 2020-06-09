class Item < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_one :order
  belongs_to :category
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_period
  belongs_to_active_hash :shipping_method 
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :postage_id, presence: true
  validates :prefecture_id, presence: true
  validates :preparation_period_id, presence: true
  validates :shipping_method_id, presence: true
end
