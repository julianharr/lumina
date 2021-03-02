class AddUtcOffsetToEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :meetup_update
    add_column :events, :meetup_update, :bigint
    remove_column :events, :meetup_event_id
    add_column :events, :meetup_event_id, :string
  end
end
