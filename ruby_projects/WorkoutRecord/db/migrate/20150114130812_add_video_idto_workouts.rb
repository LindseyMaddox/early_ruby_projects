class AddVideoIdtoWorkouts < ActiveRecord::Migration
  def up
  	add_column :workouts, :video_id, :integer
  end

  def down
  	remove_column :workouts, :video_id, :integer
  end
end
