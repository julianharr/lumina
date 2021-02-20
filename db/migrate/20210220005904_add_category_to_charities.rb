class AddCategoryToCharities < ActiveRecord::Migration[6.1]
  def change
    add_column :charities, :category, :string
  end
end
