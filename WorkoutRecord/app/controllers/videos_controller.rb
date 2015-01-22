class VideosController < ApplicationController
  # GET /videos
  # GET /videos.json
  def index
    #possibly create a color schema for the various series
    @videos = Video.search(params[:keyword]).order("name")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

def charts

  chart_work

end

def chart_work
  @data = []

  muscles = ["shoulders", "chest", "biceps", "abs", "back", "quads", "glutes", "triceps"]

  core_muscles_array = Video.all.map(&:core_muscles_worked)
 
  colors = ["#6699FF","#B2FFB2","#FFFF99","#FF7070","#FFA319", "#B870FF", "#FF85C2", "#94B8B8", "#CCFFFF", "#FFD119", "#FF4747", "#DBFF94", "#B2FFE6"]
  
  muscles_count = {}
  muscles_array = []
  counts_array = []

 #need to get count for each item in muscles and how often it shows up in keywords


core_muscles_array.each do |entry|
  temp_array = entry.split(', ')
    temp_array.uniq.each do |item|
      muscles_count[item] = (muscles_count[item] || 0) + 1
      muscles_array.push(item) unless muscles_array.include?(item)
    end
end

muscles_count.each_value do |val|
  counts_array.push(val)
end


x = 0

while x < muscles.length
  combined_hash = {}
  combined_hash["label"] = muscles[x]
  combined_hash["color"] = colors[x]
    mus_count = muscles_array.index(muscles[x])
    if muscles_array.include?(muscles[x])
      combined_hash["value"] = counts_array[mus_count]
    #but is there really a purpose for 0 values?
    else
      combined_hash["value"] = 0
    end
  @data.push(combined_hash)
  x +=1
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


