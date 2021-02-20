class AddLongitudeToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :longitude, :float
    add_column :events, :latitude, :float
  end
end
