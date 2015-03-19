class WorkoutsController < ApplicationController
  # GET /workouts
  # GET /workouts.json

  def index
    if logged_in?
      @workouts = Workout.order("date_completed").where(user_id: current_user.id).date_filter(params[:date_filter])
    
      @workout_ids = @workouts.map(&:id)

      @date_ranges = [7,14,30]

     @totals = Video.joins(:workouts).where("workouts.id in (?)", @workout_ids).sum("length")
    end

  respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workouts }
      #format.js
    end
end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
    @workout = Workout.find(params[:id])

     respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workout }
      format.js
    end
  end

  # GET /workouts/new
  # GET /workouts/new.json
  def new
    @workout = Workout.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workout }
    end
  end

  # GET /workouts/1/edit
  def edit
    @workout = Workout.find(params[:id])
  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = Workout.new(params[:workout])
    @workout.user_id = current_user.id
   # @workout = Workout.new(params[:workout].merge(:user_id => @current_user.id))

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: 'Workout was successfully created.' }
        format.json { render json: @workout, status: :created, location: @workout }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workouts/1
  # PUT /workouts/1.json
  def update
    @workout = Workout.find(params[:id])

    respond_to do |format|
      if @workout.update_attributes(params[:workout])
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
  end

end
