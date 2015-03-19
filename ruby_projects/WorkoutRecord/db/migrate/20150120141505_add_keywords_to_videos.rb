class AddKeywordsToVideos < ActiveRecord::Migration
  def change
  	add_column(:videos, :keyword, :text)
  end
end
