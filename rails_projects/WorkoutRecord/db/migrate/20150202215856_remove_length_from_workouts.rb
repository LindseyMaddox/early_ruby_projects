class RemoveLengthFromWorkouts < ActiveRecord::Migration
	def up
  	remove_column :workouts, :length, :string
  end

  def down
  	add_column :workouts, :length, :string
  end
end

