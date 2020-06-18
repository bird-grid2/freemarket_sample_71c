class Item < ApplicationRecord
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  validates :category_id, presence: true
end
