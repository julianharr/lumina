class Interest < ApplicationRecord
  # Commented out for Taggable Gem. Do not use this Model.

  # belongs_to :user, through: :userinterests, dependent: :destroy

  # vals
  validates :name, presence: true
end
