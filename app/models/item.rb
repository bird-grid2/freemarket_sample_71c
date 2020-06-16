class Item < ApplicationRecord

  belongs_to :user
  has_many   :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images

  belongs_to :category
  validates :category_id, presence: true
  belongs_to :saler, class_name: "User", :foreign_key => 'saler_id'
  belongs_to :buyer, class_name: "User", :foreign_key => 'buyer_id'

end
