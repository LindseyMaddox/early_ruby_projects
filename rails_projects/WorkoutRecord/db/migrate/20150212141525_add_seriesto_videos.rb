class AddSeriestoVideos < ActiveRecord::Migration
  def up
  	add_column :videos, :series_id, :integer
  end

  def down
  	remove_column :videos, :series_id, :integer
  end
end
