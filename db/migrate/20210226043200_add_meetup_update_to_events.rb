class AddMeetupUpdateToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :meetup_update, :datetime
  end
end
