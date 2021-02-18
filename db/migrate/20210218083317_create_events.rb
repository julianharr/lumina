class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :location
      t.text :description
      t.string :organiser
      t.integer :attendees
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
