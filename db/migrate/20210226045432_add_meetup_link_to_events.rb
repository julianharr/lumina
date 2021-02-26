class AddMeetupLinkToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :meetup_link, :string
  end
end
