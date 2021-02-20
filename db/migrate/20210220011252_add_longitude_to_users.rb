class AddLongitudeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
  end
end
