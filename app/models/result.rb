class Result < ActiveRecord::Base
  attr_accessible :daywod_id, :recd, :user_id, :rx, :note, :mins, :secs
  attr_accessor :mins, :secs
  
  belongs_to :daywod
  belongs_to :user
  has_one :wod, through: :daywod
  validates :recd, :presence => true
  validates :user_id, :presence => true

  private

    def user_assign_ok
      if current_user.signed_in? == true then
        return nil
      else
    	  return nil if :user_id != current_user.id && current_user.admin == false
    	end
    end
end
