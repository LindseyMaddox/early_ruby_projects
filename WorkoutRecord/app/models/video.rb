class Video < ActiveRecord::Base
  attr_accessible :abbreviated_name, :core_muscles_worked, :name, :notes, :category
  has_many :workouts

#a scope always returns a collection

#"The proper way to use callbacks is when you're dealing with properties
#from the same model"
#they use the before save to speed up the querying

  scope :search, ->(keyword){ where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }
  
  before_save :set_keywords

#railscast format
  #def self.search(search)
  #	if search
  #		find(:all, :conditions => ['name LIKE ? OR core_muscles_worked LIKE ? or category LIKE ?', "%#{search}%","%#{search}%", "%#{search}%"])
  #	else
  #		find(:all)
  #	end
  #end

   protected
    def set_keywords
    	#currently only looking at these but could add abbreviated name or notes if it makes sense
      self.keywords = [name, category, core_muscles_worked].map(&:downcase).join(' ')
    end


end
