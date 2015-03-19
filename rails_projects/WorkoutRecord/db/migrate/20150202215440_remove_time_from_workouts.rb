class RemoveTimeFromWorkouts < ActiveRecord::Migration
  def up
  	remove_column :workouts, :time, :string
  end

  def down
  	remove_column :workouts, :time, :string
  end
end
