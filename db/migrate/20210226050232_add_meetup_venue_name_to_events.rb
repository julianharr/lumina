class AddMeetupVenueNameToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :venue_name, :string
  end
end
