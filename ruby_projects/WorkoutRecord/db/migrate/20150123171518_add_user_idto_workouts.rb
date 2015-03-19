class AddUserIdtoWorkouts < ActiveRecord::Migration
  def up
  	add_column :workouts, :user_id, :integer
  end

  def down
  	remove_column :workouts, :user_id, :integer
  end
end
