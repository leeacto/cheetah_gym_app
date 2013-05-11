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

	before_save :reps_to_sixty

	def hist
		Daywod.past_performed(self)
	end
	
	def self.search(search)
		if search
    		where 'name LIKE ? or desc LIKE ? or seq LIKE ?', "%#{search}%","%#{search}%","%#{search}%"
    	else
    		scoped
    	end
    end

  private

  	def reps_to_sixty
      if self.wod_type == "Time"
      	self.baserep = "60"
      end
    end

end
