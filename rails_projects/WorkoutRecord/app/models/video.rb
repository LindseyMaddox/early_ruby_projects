class Video < ActiveRecord::Base
  attr_accessible :abbreviated_name, :core_muscles_worked, :name, :notes, :category, :length, :program_id
  has_many :workouts
  has_many :users, through: :workouts
  belongs_to :program

  scope :short_length_filter, ->(length){ where('length < ?', length ) if length.present? }
  scope :long_length_filter, ->(length){ where('length > ?', length ) if length.present? }
  scope :search, ->(keyword){ where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }

  scope :date_range, ->(date) { 
    if date.present? 
      Video.joins(:workouts).where('date_completed > ?', date.to_i.days.ago)
     else 
      Video.joins(:workouts).where('date_completed > ?', 4.days.ago)
    end }

  scope :muscle_removal_requests, ->(muscle) { 
    if muscle.present?
      where('core_muscles_worked LIKE ?', "%#{muscle}%" ) 
    else
      where('core_muscles_worked = ?', "placeholder")
    end }

  def self.core_muscles
  
    @core_muscles_array = self.all.map(&:core_muscles_worked)

  end
  
  def self.counting_muscle_groups

    core_muscles_array = self.core_muscles
    @muscles_count = {}

    core_muscles_array.each do |entry|
      temp_array = entry.split(', ')
        temp_array.uniq.each do |item|
          @muscles_count[item] = (@muscles_count[item] || 0) + 1
        end
    end

  @muscles_count
  end

   def self.pie_chart_work 

    @muscles_count = self.counting_muscle_groups

    @data = []

    colors = ["#6699FF","#B2FFB2","#FFFF99","#FF7070","#FFA319", "#B870FF", "#FF85C2", "#94B8B8", "#CCFFFF", "#FFD119", "#FF4747", "#DBFF94", "#B2FFE6"]

    x = 0

    @muscles_count.each do |key,value|
      combined_hash = {}
      combined_hash["color"] = colors[x]
      combined_hash["label"] = key
      combined_hash["value"] = value
        x +=1
      @data.push(combined_hash)
    end

   @data

  end

  def self.pie_chart_data
    @data = self.pie_chart_work
  end

  def self.recent_workouts(date, user)
    recent_workouts =    self.date_range(date).merge(Workout.current_user_workouts(user))
  end

  def self.next_workout_engine(date, user)

   #get recent workouts based on the date filter selected (or 4 if none selected)
    
    recent_workouts = self.recent_workouts(date, user)
    @core_muscles_array = recent_workouts.map(&:core_muscles_worked)
    recent_workout_names = recent_workouts.map(&:name)

    @muscles_count = {}
    @muscles_array = []

    @core_muscles_array.each do |entry|
        temp_array = entry.split(', ')
        temp_array.uniq.each do |item|
          @muscles_count[item] = (@muscles_count[item] || 0) + 1
        end
    end

    @video_muscles = {}

    @muscles_count

  end

  def self.max_frequency(date, user)
    @muscles_count = self.next_workout_engine(date, user)

    @max_frequency = @muscles_count.values.max

  end

def self.overworked(date, user)

    @muscles_count = self.next_workout_engine(date, user)

    @overworked = []

    @muscles_count.each do |key,value|
      if value == @max_frequency 
        @overworked.push(key)
      else
        next
      end
    end

    @overworked

end

def self.worked_hard(date, user)
  @muscles_count = self.next_workout_engine(date, user)
  @worked_hard =  []

    @muscles_count.each do |key,value|
      if value == (@max_frequency - 1) && @max_frequency > 2
        @worked_hard.push(key)
      else
        next
      end
    end

    @worked_hard
end

def self.videos_overworking_muscles(date, user)

#create a list of videos which have muscle groups that have been overworked
  
  @videos_which_overwork_muscles = {}

  @too_much = self.overworked(date, user) + self.worked_hard(date, user)

  @too_much.each do |muscle|
      @overworked_musc_video_array = Video.where('keywords like ?', "%#{muscle}%")
      @overworked_musc_video_array_names = @overworked_musc_video_array.map(&:name)
      @overworked_musc_video_array_names.each do |name|
        if @videos_which_overwork_muscles.has_key?(name)
           temp_hash = {}
           temp_hash[name] = muscle
           @videos_which_overwork_muscles.merge!(temp_hash) { |key, v1, v2| [v1, v2]}
        else 
          @videos_which_overwork_muscles[name] = muscle
        end 
      end
  end
    @videos_which_overwork_muscles
end


def self.recommended_videos(date, user, muscle)

#find videos for date range, then take out the last workout or anything that's in the overworked list
#or if the video is an exact match of muscle groups from the last workout
  
  @recommendations = []

  @max_frequency = self.max_frequency(date, user)

  muscle_removal_requests = self.muscle_removal_requests(muscle)

  @videos_to_remove = muscle_removal_requests.map(&:name)


#if max frequency is 1, then there's not any need to remove videos.

  if @max_frequency > 1
    @videos_which_overwork_muscles = self.videos_overworking_muscles(date, user)
  else
    @videos_which_overwork_muscles = {}
  end

  video_list = Video.all

  @last_workout = Video.joins(:workouts).where('user_id = ?', user.id).last

   video_list.each do |video|
      if video.name == @last_workout.name || video.core_muscles_worked == @last_workout.core_muscles_worked
       next
      elsif @videos_to_remove.include?(video.name)
        next
      elsif @videos_which_overwork_muscles.has_key?(video.name)
        next
      else 
        @recommendations.push(video)
      end
    end

    @recommendations
end

 
def self.recent_video_muscles(date, user)

  #maps video to its core muscles - THIS IS FOR THE DETAIL SECTION
  @video_muscles = {}
  recent_workouts = self.recent_workouts(date, user)

  recent_workouts.each do |item|
    @video_muscles[item.name] = item.core_muscles_worked
  end

  @video_muscles
end

  before_save :set_keywords


   protected
    def set_keywords
    	#currently only looking at these but could add abbreviated name or notes if it makes sense
      self.keywords = [name, category, core_muscles_worked].map(&:downcase).join(' ')
    end


end
