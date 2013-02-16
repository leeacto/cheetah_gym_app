module ApplicationHelper

	# Return a title on a per-page basis.
	def title
		base_title = "Cheetah Crossfit" 
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end 
	end

	def logo
		image_tag("cflogo.gif", :alt => "Sample App", :class => "round") 
	end
end