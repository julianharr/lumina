class AddHostNameToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :host_name, :string
    add_column :events, :host_link, :string
  end
end
