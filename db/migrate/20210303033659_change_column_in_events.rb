class ChangeColumnInEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :latitude, :decimal, { precision: 10, scale: 6 }
    change_column :events, :longitude, :decimal, { precision: 10, scale: 6 }
  end
end
