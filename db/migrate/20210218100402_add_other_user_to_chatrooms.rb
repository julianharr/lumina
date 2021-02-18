class AddOtherUserToChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :chatrooms, :user_two, foreign_key: {to_table: :users}, null: true
    add_reference :chatrooms, :user_three, foreign_key: {to_table: :users}, null: true
    add_reference :chatrooms, :user_four, foreign_key: {to_table: :users}, null: true
    add_reference :chatrooms, :user_five, foreign_key: {to_table: :users}, null: true
  end
end
