class AddGitNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :git_name, :string, default: ""
  end
end
