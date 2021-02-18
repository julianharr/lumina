class CreateUserinterests < ActiveRecord::Migration[6.1]
  def change
    create_table :userinterests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
