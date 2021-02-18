class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :user_two, optional: true, class_name: :User, foreign_key: :user_two_id
  belongs_to :user_three, optional: true, class_name: :User, foreign_key: :user_three_id
  belongs_to :user_four, optional: true, class_name: :User, foreign_key: :user_four_id
  belongs_to :user_five, optional: true, class_name: :User, foreign_key: :user_five_id
end

