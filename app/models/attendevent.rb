class Attendevent < ApplicationRecord
  belongs_to :user
  belongs_to :event # update doctor.rb

  # vals
  validates :user_id, uniqueness: { scope: :event_id }
end
