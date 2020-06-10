class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  has_many :item_images, dependent: :destroy, inverse_of: :item
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :saler, class_name: "User", :foreign_key => 'saler_id'
  belongs_to :buyer, class_name: "User", :foreign_key => 'buyer_id'
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_period
  belongs_to_active_hash :shipping_method 
  validates :category, presence: true
  validates :condition, presence: true
  validates :postage, presence: true
  validates :prefecture, presence: true
  validates :preparation_period, presence: true
  validates :shipping_method, presence: true
end
