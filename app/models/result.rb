class Result < ActiveRecord::Base
  attr_accessible :daywod_id, :recd, :user_id

  belongs_to :daywod
  belongs_to :user

  validates :recd, :presence => true

end
