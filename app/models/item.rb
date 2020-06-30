class Item < ApplicationRecord
  
  belongs_to :user
  has_many   :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images

  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  validates :category_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  def already_liked(user_id)
    likes.find_by(user_id: user_id)
  end
end

