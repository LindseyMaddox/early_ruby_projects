class RenameSeriesIdProgramIdonVideos < ActiveRecord::Migration
  def up
  	rename_column :videos, :series_id, :program_id
  end

  def down
  	rename_column :videos, :program_id, :series_id
  end
end
