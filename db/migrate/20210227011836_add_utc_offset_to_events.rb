class AddUtcOffsetToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :utc_offset, :integer
    # change_column :events, :meetup_update, 'cast(to_char((current_timestamp)::TIMESTAMP,'yyyymmddhhmiss') as BigInt)'
    # change_column :events, :meetup_event_id, 'integer USING CAST(meetup_event_id AS integer)'
    remove_column :events, :meetup_update
    add_column :events, :meetup_update, :bigint
    remove_column :events, :meetup_event_id
    add_column :events, :meetup_event_id, :string
  end
end
