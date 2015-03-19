class DropVideoSeries < ActiveRecord::Migration
  def up
  	drop_table :video_series
  end

  def down
  	create_table :video_series do |t|
      t.string :video_id
      t.string :integer
      t.string :series_id
      t.string :integer

      t.timestamps
    end
  end
end
