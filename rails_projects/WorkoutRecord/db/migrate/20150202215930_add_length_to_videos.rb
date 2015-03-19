class AddLengthToVideos < ActiveRecord::Migration
  def up
  	add_column :videos, :length, :integer
  end

  def down
  	remove_column :videos, :length, :integer
  end
end
