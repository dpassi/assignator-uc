class AddPartToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    add_index :users, :role
  end
end
