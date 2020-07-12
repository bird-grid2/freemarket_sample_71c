class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category
  belongs_to :seller, class_name: "User", :foreign_key => 'seller_id'
  belongs_to :buyer, class_name: "User", :foreign_key => 'buyer_id', optional: true

  has_many   :item_images, dependent: :destroy, inverse_of: :item
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_period
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :postage

  validates :postage_id, :price, :item_images, presence: true
  validates :category_id, :name, :description, :condition_id, :postage_id, :prefecture_id, :preparation_period_id, :price, :shipping_method_id, :item_images,  presence: true
  validates :name, :brand, length: {maximum: 15 }
  validates :description, length: {maximum: 200 }
  validates :price, numericality:  { only_integer: true }

  has_many :users, through: :likes
  

  def already_liked(user_id)
    likes.find_by(user_id: user_id)
  end

  def self.search(keyword)
    return Item.all unless keyword
    Item.where('name LIKE ?', "%#{keyword}%")
  end

end

