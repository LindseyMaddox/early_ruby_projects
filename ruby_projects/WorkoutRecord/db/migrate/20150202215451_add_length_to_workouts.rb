class AddLengthToWorkouts < ActiveRecord::Migration
   def up
  	add_column :workouts, :length, :integer
  end

  def down
  	remove_column :workouts, :length, :integer
  end
end
