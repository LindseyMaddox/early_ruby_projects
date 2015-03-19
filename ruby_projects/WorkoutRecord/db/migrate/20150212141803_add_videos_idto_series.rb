class AddVideosIdtoSeries < ActiveRecord::Migration
  def up
  	add_column :series, :video_id, :integer
  end

  def down
  	remove_column :series, :video_id, :integer
  end
end
