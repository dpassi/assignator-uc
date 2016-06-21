class AddLatitudeToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :latitude, :string
  end
end
