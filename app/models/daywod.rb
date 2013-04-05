class Daywod < ActiveRecord::Base
  attr_accessible :performed, :wod_id
  
  belongs_to :wod
  has_many :results
  
  validates :performed, :presence => true
  validates :wod_id, :presence => true

  def self.past_performed(wod)
  	where("wod_id = ?", wod)
  end
end
