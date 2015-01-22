class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :abbreviated_name
      t.string :type
      t.string :core_muscles_worked
      t.text :notes

      t.timestamps
    end
  end
end
