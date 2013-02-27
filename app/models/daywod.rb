class Daywod < ActiveRecord::Base
  attr_accessible :performed, :wod_id
  
  belongs_to :wod
  
  validates :performed, :presence => true
  validates :wod_id, :presence => true
end
