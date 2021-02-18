class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :wishlist, null: false, foreign_key: true
      t.string :name
      t.float :price
      t.string :link
      t.text :description

      t.timestamps
    end
  end
end
