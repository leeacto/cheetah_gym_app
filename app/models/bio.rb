class Bio < ActiveRecord::Base
  attr_accessible :experience, :fav, :height, :unfav, :user_id, :weight
  belongs_to :user

  def feet
    height.to_i / 12
  end

  def inches
    height.to_i % 12
  end

	def height_in_ft
		"#{feet}'#{inches}"
	end
end
