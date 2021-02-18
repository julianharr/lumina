class CreateDonates < ActiveRecord::Migration[6.1]
  def change
    create_table :donates do |t|
      t.float :amount
      t.references :user, null: false, foreign_key: true
      t.references :charity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
