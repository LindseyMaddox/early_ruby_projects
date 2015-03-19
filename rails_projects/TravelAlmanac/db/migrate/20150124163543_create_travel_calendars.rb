class CreateTravelCalendars < ActiveRecord::Migration
  def change
    create_table :travel_calendars do |t|
      t.string :location_id
      t.string :month_id

      t.timestamps
    end
  end
end
