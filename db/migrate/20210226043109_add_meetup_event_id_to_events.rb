class AddMeetupEventIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :meetup_event_id, :integer
  end
end
