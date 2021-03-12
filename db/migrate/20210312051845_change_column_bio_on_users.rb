class ChangeColumnBioOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :bio, :text, default: ""
    change_column :users, :nickname, :string, default: ""
    change_column :users, :first_name, :string, default: ""
    change_column :users, :last_name, :string, default: ""
  end
end
