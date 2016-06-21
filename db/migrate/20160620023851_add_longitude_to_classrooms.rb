class AddLongitudeToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :longitude, :string
  end
end
