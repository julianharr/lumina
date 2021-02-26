class AddCategoryToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :category, :string
  end
end
