class CreateAssignations < ActiveRecord::Migration
  def change
    create_table :assignations do |t|
      t.integer :schedule_id
      t.integer :classroom_id
      t.timestamps null: false
    end
  end
end
