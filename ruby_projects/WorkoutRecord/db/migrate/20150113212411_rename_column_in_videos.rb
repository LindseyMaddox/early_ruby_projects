class RenameColumnInVideos < ActiveRecord::Migration
  def up
  	rename_column :videos, :type, :category
  end

  def down
  	rename_column :videos, :category, :type
  end
end
