class ChangeContinenttoRegion < ActiveRecord::Migration
  def up
  	rename_column :locations, :continent, :region
  end
  def down
  	rename_column :locations, :region, :continent
  end
end
