class Item < ApplicationRecord
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  validates :category_id, presence: true

  def already_liked(user_id)
    likes.find_by(user_id: user_id)
  end
end