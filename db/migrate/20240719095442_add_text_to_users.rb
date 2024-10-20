class AddTextToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :text, :string
  end
end
