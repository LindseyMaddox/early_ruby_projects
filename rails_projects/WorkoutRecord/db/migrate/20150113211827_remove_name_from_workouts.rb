class RemoveNameFromWorkouts < ActiveRecord::Migration
  def up
  	remove_column :workouts, :name, :string
  end

  def down
  	add_column :workouts, :name, :string
  end
end
