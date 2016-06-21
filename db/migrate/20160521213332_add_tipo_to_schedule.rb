class AddTipoToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :tipo, :string
  end
end
