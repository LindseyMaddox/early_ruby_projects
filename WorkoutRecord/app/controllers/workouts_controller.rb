class WorkoutsController < ApplicationController
  # GET /workouts
  # GET /workouts.json

  def index
    
    @workouts = Workout.order("date_completed").recent
    @videos = Video.all
    
    @totals = Workout.recent.sum("time")

  respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workouts }
      #format.js
    end
end

def charts

      pie_chart_data

      bar_chart_data

end

def pie_chart_data

  @data = []
  amounts = []
  colors = ["#6699FF","#B2FFB2","#FFFF99","#FF7070","#FFA319", "#B870FF", "#FF85C2", "#94B8B8", "#CCFFFF", "#FFD119", "#FF4747", "#DBFF94", "#B2FFE6"]
     
  #this is a little clunky, but probably has more to do with the data structure than the code itself

  names = ["Ripped in 30", "30 Day Shred", "6 Week 6 Pack", "Body Revolution", "Banish Fat Cardio"]
  
  ripped_items = Workout.joins("inner join videos on videos.id = workouts.video_id where videos.name like
    '%ripped%'").sum("workouts.time")
  shred_items = Workout.joins("inner join videos on videos.id = workouts.video_id where videos.name like
    '%shred%'").sum("workouts.time")
   abs_items = Workout.joins("inner join videos on videos.id = workouts.video_id where videos.name like
    '%six pack%'").sum("workouts.time")
   body_items = Workout.joins("inner join videos on videos.id = workouts.video_id where videos.name like
      '%body revo%'").sum("workouts.time")
    banish_items = Workout.joins("inner join videos on videos.id = workouts.video_id where videos.name like
      '%banish fat%'").sum("workouts.time")

    amounts.push(ripped_items)
    amounts.push(shred_items)
    amounts.push(abs_items)
    amounts.push(body_items)
    amounts.push(banish_items)

    x = 0

    while x < amounts.length 
      combined_hash = {}

      combined_hash["label"] = names[x] 
      combined_hash["color"] = colors[x]
      combined_hash["value"] = amounts[x]
      @data.push(combined_hash)
      x +=1
    end

end

def bar_chart_data
  #bar chart average calculations

      @average_array = []
      @videos_array = []
      @sum_array = []
      
      sum_hash = Workout.joins(:video).group(:abbreviated_name).sum("time")

      count_hash = Workout.joins(:video).group(:abbreviated_name).count

      sum_array = sum_hash.map { |x| x }

      count_array = count_hash.map { |x| x }

      count = 0

      while count < sum_array.length
        new_value = (sum_array[count][1] / count_array[count][1])
       @average_array.push(new_value)
       @videos_array.push(sum_array[count][0])
        count +=1
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

    respond_to do |format|
      format.html { redirect_to workouts_url }
      format.json { head :no_content }
    end
  end
end
