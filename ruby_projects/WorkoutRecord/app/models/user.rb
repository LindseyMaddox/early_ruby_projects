
class User < ActiveRecord::Base

  attr_accessible :name, :weight, :password
  validates :name, presence: true, length: { maximum: 25 }
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :workouts
  has_many :videos, through: :workouts

  def self.authenticate(name, password)
  	user = User.where(name: name).first
  	user && user.authenticate(password)
  end
end
