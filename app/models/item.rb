class Item < ApplicationRecord
  belongs_to :user
  has_many   :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
end
