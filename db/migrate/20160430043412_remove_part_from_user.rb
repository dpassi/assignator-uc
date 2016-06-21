class RemovePartFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rol_id, :integer
  end
end
