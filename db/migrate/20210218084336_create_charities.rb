class CreateCharities < ActiveRecord::Migration[6.1]
  def change
    create_table :charities do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :website

      t.timestamps
    end
  end
end
