class Workout < ActiveRecord::Base
  attr_accessible :date_completed, :video_id, :name, :time
  belongs_to :video

#we eventually want to make this selectable
  scope :recent, -> { where('date_completed > ?', 14.days.ago )}

 scope :search, ->(keyword){ where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }
  
end
