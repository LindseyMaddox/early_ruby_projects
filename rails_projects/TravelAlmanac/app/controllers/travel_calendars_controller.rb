class TravelCalendarsController < ApplicationController
  before_action :set_travel_calendar, only: [:show, :edit, :update, :destroy]

  # GET /travel_calendars
  # GET /travel_calendars.json
 def index
    @year_round_locations = Location.year_round_locations

    @current_month = Month.current_month
    @current_month_locations = Month.current_month_locations
    
    @best = Month.best
    @best_months = @best.map(&:name)
    
    @max_count =  Month.max_count

  end

  # GET /travel_calendars/1
  # GET /travel_calendars/1.json
  def show
  end

  # GET /travel_calendars/new
  def new
    @travel_calendar = TravelCalendar.new
  end

  # GET /travel_calendars/1/edit

  # POST /travel_calendars
  # POST /travel_calendars.json
  def create
    @travel_calendar = TravelCalendar.new(travel_calendar_params)

    respond_to do |format|
      if @travel_calendar.save
        format.html { redirect_to @travel_calendar, notice: 'Travel calendar was successfully created.' }
        format.json { render :show, status: :created, location: @travel_calendar }
      else
        format.html { render :new }
        format.json { render json: @travel_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travel_calendars/1
  # PATCH/PUT /travel_calendars/1.json
  def update
    respond_to do |format|
      if @travel_calendar.update(travel_calendar_params)
        format.html { redirect_to @travel_calendar, notice: 'Travel calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @travel_calendar }
      else
        format.html { render :edit }
        format.json { render json: @travel_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_calendars/1
  # DELETE /travel_calendars/1.json
  def destroy
    @travel_calendar.destroy
    respond_to do |format|
      format.html { redirect_to travel_calendars_url, notice: 'Travel calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel_calendar
      @travel_calendar = TravelCalendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_calendar_params
      params.require(:travel_calendar).permit(:location_id, :month_id)
    end
end
