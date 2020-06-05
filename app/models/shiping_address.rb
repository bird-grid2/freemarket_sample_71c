class ShipingAddress < ApplicationRecord
  belongs_to :user, optional: true
  validates :post_code, :prefecture, :city, :block, presence: true
end
