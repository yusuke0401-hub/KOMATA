class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :profile, :text
  end
end
