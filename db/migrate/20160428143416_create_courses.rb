class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :initials
      t.string :section
      t.integer :nrc
      t.text :information
      t.integer :vacancy
      t.integer :power_n
      t.boolean :projector

      t.timestamps null: false
    end
  end
end
