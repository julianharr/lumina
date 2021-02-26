class Message < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :chatroom

  # validations
  validates :content, presence: true
end
