class Workout < ActiveRecord::Base
  attr_accessible :date_completed, :video_id, :user_id, :name, :time
  belongs_to :video
  belongs_to :user


	scope :date_filter, ->(range){
		if range.present?
	 		where('date_completed > ?', range.to_i.days.ago ) 
	    else
	    where('date_completed > ?', 14.days.ago ) 
	    end } 
	scope :short_length_filter, ->(length){ joins(:videos).where('length < ?', length ) if length.present? }
	scope :long_length_filter, ->(length){ joins(:videos).where('length > ?', length ) if length.present? }
	 
	scope :search, ->(keyword){ where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }
	scope :current_user_workouts, ->(user) { where('workouts.user_id = ?', user.id) }
end
