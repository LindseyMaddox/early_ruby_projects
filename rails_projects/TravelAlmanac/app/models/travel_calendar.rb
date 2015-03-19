class TravelCalendar < ActiveRecord::Base
	belongs_to :location
	belongs_to :month

end
