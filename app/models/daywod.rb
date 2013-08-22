class Daywod < ActiveRecord::Base
  attr_accessible :performed, :wod_id, :personal	
  
  belongs_to :wod
  has_many :results
  
  validates :performed, :presence => true
  validates :wod_id, :presence => true

end
