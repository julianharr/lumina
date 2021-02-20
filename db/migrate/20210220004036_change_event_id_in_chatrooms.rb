class ChangeEventIdInChatrooms < ActiveRecord::Migration[6.1]
  def change
    remove_reference :chatrooms, :event
    add_reference :chatrooms, :event, foreign_key: true, null: true
  end
end
