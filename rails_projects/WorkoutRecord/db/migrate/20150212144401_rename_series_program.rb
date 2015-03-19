class RenameSeriesProgram < ActiveRecord::Migration
  def up
  	rename_table :series, :programs
  end

  def down
  	rename_table :programs, :series
  end
end
