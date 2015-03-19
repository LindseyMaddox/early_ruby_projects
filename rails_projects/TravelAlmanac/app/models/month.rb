class Month < ActiveRecord::Base
	has_many :travel_calendars
	has_many :locations, through: :travel_calendars

	scope :best, -> { all.group_by { |m| m.locations.count }.max.last }
	scope :month_filter, ->(name) {where('months.name = ?', name) if name.present?}
	scope :filter, ->(region) {joins(:locations).where('locations.reg = ?', region) if region.present?}


	def self.max_count
		max_count = []
		best_hash = self.all.group_by { |m| m.locations.count }
   		
   		best_hash.keys.max
    end

    def self.current_month
    	date = Date.today
    	current_month = date.strftime("%B")
    end

    def self.current_month_locations
    	
    	current_month = self.current_month

    	current_month_id = self.select(:id).where(name: current_month).first 

    	current_month_locations = self.select("locations.name, locations.country").where(id: current_month_id).joins(:locations)
  	
  		current_month_locations
  	end

#REVIEW THIS
	def self.unique_destination

	    locations = Location.joins(:months)

	    location_array = locations.map(&:name)

	    location_count = {}

	    location_array.each do |location|
	      location_count[location] = (location_count[location] || 0) + 1
	    end

	    unique_group = []

	    location_count.each do |location, value|
	      if value == location_count.values.min
	        unique_group.push(location)
	      end
	    end
#ok through here

#so in unique group we have the list of locations for which the # of months you can visit
#is equal to the minimum

	    @temp_array = []
	    @unique_months_array = []
	    
	    #sending unique group to another method
	    
	    @unique_locations_map = {}
	    
	    unique_group.map do |location|
	      locations = unique_map(location)
	    end

	    #still need to refactor this to be more direct
	    x = 0
	    while x < (@temp_array.length-1) 
	      @unique_locations_map[@temp_array[x]] = @temp_array[(x+1)] 
		  x +=2
	    end
	   
	    @unique_locations_map 

	    reverse_map = {}
	   
	    @unique_locations_map.each do |key,value|
			reverse_map[value] = key
		end

#probably should move this to another method	
		@unique_months = {}
		reverse_map.each do |key, value|
			x = 0
			while x < key.length
				if @unique_months.has_key?(key[x])
					@temp_hash = {}
					@temp_hash[key[x]] = value
					@unique_months.merge!(@temp_hash) { |key,v1,v2| [v1,v2]}
				else
					@unique_months[key[x]] = value
				end
				x +=1
			end
		end

		@unique_months
	end

#get the list of months that match the location
	def self.unique_map(location)

	  months = Month.joins(:locations).where("locations.name = ?", location)
	  
	  month_list = months.map(&:name)
	   
	  @temp_array.push(location)
	  @temp_array.push(month_list)

	end

end
