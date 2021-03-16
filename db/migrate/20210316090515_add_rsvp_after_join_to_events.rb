class AddRsvpAfterJoinToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :group_rsvp_after, :boolean, default: false
    add_column :events, :group_questions, :text
  end
end
