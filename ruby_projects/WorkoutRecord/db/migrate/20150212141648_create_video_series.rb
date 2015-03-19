class CreateVideoSeries < ActiveRecord::Migration
  def change
    create_table :video_series do |t|
      t.string :video_id
      t.string :integer
      t.string :series_id
      t.string :integer

      t.timestamps
    end
  end
end
