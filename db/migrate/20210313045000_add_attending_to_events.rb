class AddAttendingToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :attending, :boolean
  end
end
