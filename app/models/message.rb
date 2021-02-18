class Message < ApplicationRecord
  belongs_to :chatroom, dependent: :destroy
end
