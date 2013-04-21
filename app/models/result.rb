class Result < ActiveRecord::Base
  attr_accessible :daywod_id, :recd, :user_id, :rx, :note, :mins, :secs
  attr_accessor :mins, :secs
  
  belongs_to :daywod
  belongs_to :user

  validates :recd, :presence => true
  before_create :mins_to_secs
  before_save :user_assign_ok


  private
    def mins_to_secs(mins, secs)
      if mins.nil? then
        mins = 0
      end
      if secs.nil? then
        secs = 0
      end
      self.recd ||= (60*mins) + secs
    end

    def user_assign_ok
      if current_user.signed_in? == true then
        return nil
      else
    	  return nil if :user_id != current_user.id && current_user.admin == false
    	end
    end
end
