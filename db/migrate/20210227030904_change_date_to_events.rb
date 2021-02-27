class ChangeDateToEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :meetup_update, :bigint
  end
end
