class Result < ActiveRecord::Base
  attr_accessible :daywod_id, :recd, :user_id, :rx, :note, :mins, :secs
  attr_accessor :mins, :secs
  
  belongs_to :daywod
  belongs_to :user
  has_one :wod, through: :daywod
  validates :recd, :presence => true, :numericality => { :greater_than => 0 }
  validates :user_id, :presence => true

  scope :rxd, -> {where(:rx => true)}
  scope :sxd, -> {where(:rx => false)}
  
  def formatted
    if self.wod.wod_type == "Time"
      Time.local(1999,1,1,0,
      self.mins, self.secs).strftime "%M:%S"
    else
     "#{self.rounds}#{self.plus_reps}"
    end
  end

  def mins
    (self.recd/60).to_i
  end

  def secs
    self.recd % 60
  end

  def rounds
    (self.recd/self.wod.baserep).to_i
  end

  def plus_reps
    tester = (self.recd % self.wod.baserep).to_i
    if tester > 0
      "+ #{tester}"
    else
      ""
    end
  end

  private

  def user_assign_ok
    if current_user.signed_in? == true then
      return nil
    else
      return nil if :user_id != current_user.id && current_user.admin == false
    end
  end
end
