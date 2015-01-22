class RenameKeywordsColumnInVideos < ActiveRecord::Migration
  def up
  	rename_column(:videos, :keyword, :keywords)
  end

  def down
  	rename_column(:videos, :keywords, :keyword)
  end
end
