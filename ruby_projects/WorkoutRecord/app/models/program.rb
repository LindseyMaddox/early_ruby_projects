class Program < ActiveRecord::Base
  attr_accessible :name

  has_many :videos  

  	def self.programs_with_workouts(user)
		joins('inner join videos on 
	  	videos.program_id = programs.id inner join workouts on workouts.video_id = videos.id').merge(Workout.current_user_workouts(user)).group("programs.id")
	end

	def self.names_with_workouts(user)
	  self.programs_with_workouts(user).map(&:name)
	end

	def self.programs_with_time(user)
		self.programs_with_workouts(user).sum("videos.length")
	end

	def self.pie_chart_data(user)
		@data = pie_chart_work(user)
	end

	def self.pie_chart_work(user)

	  @amounts = []
	  @data = []
	  colors = ["#6699FF","#B2FFB2","#FFFF99","#FF7070","#FFA319", "#B870FF", "#FF85C2", "#94B8B8", "#CCFFFF", "#FFD119", "#FF4747", "#DBFF94", "#B2FFE6"]
	     
	  @names = self.names_with_workouts(user)
	  programs_with_time = self.programs_with_time(user)

	   programs_with_time.each do |key,value|
	    @amounts.push(value)
	  end

	    x = 0
	    while x < @names.length 
	      combined_hash = {}
	        combined_hash["label"] = @names[x] 
	        combined_hash["color"] = colors[x]
	        combined_hash["value"] = @amounts[x]
	      @data.push(combined_hash)
	      x +=1
	    end
	    @data
	  end
end