class DropWhentoVisits < ActiveRecord::Migration
	  def up
	  	drop_table :when_to_visits
	  end
	  def down
	  	  create_table "when_to_visits", force: true do |t|
	    t.string   "location_id"
	    t.string   "integer"
	    t.string   "month_id"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  	end
	  end
end
