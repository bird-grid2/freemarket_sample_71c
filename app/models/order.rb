class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :shipping_address, presence: true  
  validates :cards, presence: true

end
