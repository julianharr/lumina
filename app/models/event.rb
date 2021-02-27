class Event < ApplicationRecord
  # ass
  belongs_to :user
  has_many :chatrooms, dependent: :destroy

  # has_many :messages, through: :chatrooms, dependent: :destroy
  # vals
  validates :name, presence: true
  validates :date, presence: true
  validates :description,
            length: { maximum: 10_000, too_long: "%{count} characters is the maximum allowed" }
  # validates :organiser, presence: true
  validates :attendees, numericality: { only_integer: true }
  ## active storage
  has_one_attached :image
end
