class MonthsController < ApplicationController
	def index
		@months = Month.month_filter(params[:month_filter])
		@locations = Location.all
		@continents = Location.all.map(&:region).uniq
		@names = Month.all.map(&:name)
	end


	def summary

		#@months = Month.multi_month_filter.params[:ids]
		if params[:ids].present?
			@months = Month.where('id IN (?)', params[:ids]) 
		else
			@months = Month.all
		end

		@multi_months = Month.all
		@names = Month.all.map(&:name)

		@unique_months = Month.unique_destination
	end

end