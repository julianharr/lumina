class ChangeDescriptionToString < ActiveRecord::Migration[6.1]
  def change
    change_column(:events, :description, :string)
  end
end
