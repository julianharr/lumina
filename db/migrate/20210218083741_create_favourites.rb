class CreateFavourites < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.references :favourited, polymorphic: true, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
