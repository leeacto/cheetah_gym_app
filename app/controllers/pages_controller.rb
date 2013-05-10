class PagesController < ApplicationController
  def home
  	@title = "Home"
    @daywods = Daywod.all
  end

  def contact
  	@title = "Contact"
  end

  def about
  	@title = "About"
  end

  def help
  	@title = "Help"
  end
end
