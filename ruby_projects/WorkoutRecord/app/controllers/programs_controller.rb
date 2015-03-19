class ProgramsController < ApplicationController
	def charts
		if logged_in?
			 @names = Program.names_with_workouts(current_user)

			 @programs_with_wo = Program.programs_with_workouts(current_user)

			 @data = Program.pie_chart_data(current_user)
		end
	end

end