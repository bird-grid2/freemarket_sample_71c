class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  belongs_to :category
end
