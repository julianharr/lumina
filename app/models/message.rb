class Message < ApplicationRecord
  after_create :broadcast_message
  # associations
  belongs_to :user
  belongs_to :chatroom

  # validations
  validates :content, presence: true

  def broadcast_message
    ChatroomChannel.broadcast_to(
        chatroom,
        ApplicationController.render(partial: "messages/message", locals: { message: self, user_is_messages_author: false })
    )
  end
end
