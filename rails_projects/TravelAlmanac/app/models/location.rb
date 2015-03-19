class Location < ActiveRecord::Base
	has_many :travel_calendars
	has_many :months, through: :travel_calendars
	
	scope :filter, ->(region) {where('locations.region = ?', region) if region.present?}
	scope :year_round_locations, -> { joins(:travel_calendars).having('count(name) = 12').group(:name) }
	scope :unique_regions, -> { all.map(&:region).uniq }
end
