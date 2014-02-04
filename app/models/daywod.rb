class Daywod < ActiveRecord::Base
  attr_accessible :performed, :wod_id, :personal  
  
  belongs_to :wod
  has_many :results, :dependent => :destroy
  has_many :athletes, through: :results, source: :user
  validates :performed, :presence => true
  validates :wod_id, :presence => true
  validates_uniqueness_of :wod_id, scope: :performed

	scope :impersonal, -> { where(personal: false) }
	scope :current, -> { where("performed <= ?", Time.new) }
end
