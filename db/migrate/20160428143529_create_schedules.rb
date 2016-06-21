class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :nrc
      t.string :module
      t.string :date
      t.string :type
      t.timestamps null: false
    end
  end
end
