class Daywod < ActiveRecord::Base
  attr_accessible :performed, :wod_id, :personal  
  
  belongs_to :wod
  has_many :results, :dependent => :destroy
  has_many :athletes, through: :results, source: :user
  validates :performed, :presence => true, :uniqueness => true
  validates :wod_id, :presence => true

end
