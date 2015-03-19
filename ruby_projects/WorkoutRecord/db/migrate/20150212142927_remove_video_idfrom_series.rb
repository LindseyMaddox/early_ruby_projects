class RemoveVideoIdfromSeries < ActiveRecord::Migration
  def up
  	remove_column :series, :video_id, :integer
  end


  def down
  	add_column :series, :video_id, :integer
  end
end
