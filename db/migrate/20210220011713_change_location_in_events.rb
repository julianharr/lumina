class ChangeLocationInEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :location, :address
  end
end
