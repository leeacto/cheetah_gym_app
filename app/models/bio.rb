class Bio < ActiveRecord::Base
  attr_accessible :experience, :fav, :height, :unfav, :user_id, :weight
  belongs_to :user


end
