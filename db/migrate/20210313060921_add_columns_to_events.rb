class AddColumnsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :group_url, :string
    add_column :events, :group_id, :integer
    add_column :events, :group_quest_required, :boolean, default: false
  end
end
