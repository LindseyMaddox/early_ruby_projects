class LocationsController < ApplicationController
	def index
		@locations = Location.filter(params[:filter])
		@months = Month.order(:id)
		@regions = Location.unique_regions
		@year_round_locations = Location.year_round_locations
	end


	  # GET /locations/1
	  # GET /locations/1.json
	  def show
	    @location = Location.find(params[:id])
	    @months = Month.all.map(&:name)
	    
	     respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @location }
	      format.js
	    end
	  end

	  # GET /locations/new
	  # GET /locations/new.json
	  def new
	    @location = Location.new
	    @months = Month.all
	    @countries = Location.all.map(&:country).uniq

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @location }
	    end
	  end

	  # GET /locations/1/edit
	  def edit
	    @location = Location.find(params[:id])
	  end

	  # POST /locations
	  # POST /locations.json
	  def create
	    @location = Location.new(location_params)

	    respond_to do |format|
	      if @location.save
	        format.html { redirect_to @location, notice: 'location was successfully created.' }
	        format.json { render json: @location, status: :created, location: @location }
	        format.js
	      else
	        format.html { render action: "new" }
	        format.json { render json: @location.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  # PUT /locations/1
	  # PUT /locations/1.json
	  def update
	    @location = Location.find(params[:id])

	    respond_to do |format|
	      if @location.update_(location_params)
	        format.html { redirect_to @location, notice: 'location was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @location.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  # DELETE /locations/1
	  # DELETE /locations/1.json
	  def destroy
	    @location = Location.find(params[:id])
	    @location.destroy

	    respond_to do |format|
	      format.html { redirect_to locations_url }
	      format.json { head :no_content }
	    end
	  end

private
	def location_params
      params.require(:location).permit(:name, :country,
                                   :region,
                                   { month_ids: []} )
    end
end