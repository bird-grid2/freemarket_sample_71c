class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many   :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images

  #belongs_to :category
  #validates :category_id, presence: true
  belongs_to_active_hash :postage

  belongs_to :seller, class_name: "User", :foreign_key => 'seller_id'
  belongs_to :buyer, class_name: "User", :foreign_key => 'buyer_id'

  validates :postage_id, :price, :item_images, presence: true

end
