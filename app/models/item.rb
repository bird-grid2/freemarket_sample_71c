class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  belongs_to :category
  has_many :item_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # belongs_to_active_hash :condition
  # belongs_to_active_hash :postage
  # belongs_to_active_hash :prefecture
  # belongs_to_active_hash :preparation_period

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  accepts_nested_attributes_for :item_images, allow_destroy: true
end
