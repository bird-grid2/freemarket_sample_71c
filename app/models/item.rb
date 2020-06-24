class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :seller, class_name: "User", :foreign_key => 'seller_id'
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_period
  belongs_to_active_hash :shipping_method
  validates :category_id, :name, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :preparation_period_id, :price, :shipping_method_id, :item_images, presence: true
  validates :name, :brand, length: {maximum: 15 }
  validates :description, length: {maximum: 200 }
  validates :price, numericality: true
end
