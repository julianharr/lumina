class Item < ApplicationRecord
  # ass
  belongs_to :wishlist
  # need to fix below
  # belongs_to :user, through: :wishlist, dependent: :destroy

  # vals
  validates :name, presence: true
  validates :price, presence: true
  validates :link, presence: true
  validates :description, presence: true,
                          length: { maximum: 144, too_long: "%{count} characters is the maximum allowed" }
  ## Images
  has_many_attached :images
end
