class Wod < ActiveRecord::Base
  attr_accessible :baserep, :desc, :name, :seq, :wod_type

  has_many :daywods, :dependent => :destroy
  
  validates :baserep, :presence => true
	validates :desc, :presence => true
	validates :name, :presence => true,
						:length => { :maximum => 10 },
						:uniqueness => { :case_sensitive => false }
	validates :seq, :presence => true
	validates :wod_type, :presence => true
end
