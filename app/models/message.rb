class Message < ApplicationRecord
  # ass
  belongs_to :chatroom, dependent: :destroy
  belongs_to :user
  # val
  validates :content, presence: true
end
