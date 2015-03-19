class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.date :date_completed
      t.string :name
      t.integer :time

      t.timestamps
    end
  end
end
