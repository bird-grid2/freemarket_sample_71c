class ItemImage < ApplicationRecord
  
  belongs_to :item
  mount_uploaders :image, ImageUploader
  serialize :images, JSON 
end
