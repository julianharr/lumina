class Attendevent < ApplicationRecord
  belongs_to :user
  belongs_to :event # update doctor.rb
end
