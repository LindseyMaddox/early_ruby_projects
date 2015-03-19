class VideosController < ApplicationController
  # GET /videos
  # GET /videos.json
 
  def index

    @videos = Video.search(params[:keyword]).short_length_filter(params[:short_length_filter]).long_length_filter(params[:long_length_filter]).order("name")

    @video_length_ranges = [30,35]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

def charts

  @data = Video.pie_chart_data

end

def recommendations
 
  if logged_in?
    @recent_workouts = Video.recent_workouts(params[:date_range], current_user)

    @recommendations = Video.recommended_videos(params[:date_range], current_user, params[:muscle_removal_requests])

    @video_muscles = Video.recent_video_muscles(params[:date_range], current_user)

    @date_ranges = [7,10,14]
    @overworked = Video.overworked(params[:date_range], current_user)
    @worked_hard = Video.worked_hard(params[:date_range], current_user)
    @muscle_removal_options = ["biceps", "back", "shoulders", "chest", "triceps"]
    @muscles_to_remove = Video.muscle_removal_requests(params[:muscle_removal_requests])
    @max_frequency = Video.max_frequency(params[:date_range], current_user)

  end
end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

end


