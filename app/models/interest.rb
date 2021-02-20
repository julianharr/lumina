class Interest < ApplicationRecord
  # ass
  belongs_to :user, through: :userinterests, dependent: :destroy

  # vals
  validates :name, presence: true
end
