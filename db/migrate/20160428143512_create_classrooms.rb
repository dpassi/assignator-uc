class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :identifier
      t.string :name
      t.text :information
      t.integer :floor
      t.integer :capacity
      t.integer :power_n
      t.boolean :projector

      t.timestamps null: false
    end
  end
end
