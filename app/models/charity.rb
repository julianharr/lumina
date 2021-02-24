class Charity < ApplicationRecord
  # ass
  has_many :donate
  has_many :users, through: :donate, dependent: :destroy

  # vals
  validates :location, presence: true
  validates :website, presence: true
  # validates :category, presence: true
  validates :name, presence: true
  validates :description, presence: true,
                          length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
