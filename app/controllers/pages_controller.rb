class PagesController < ApplicationController
  def home
    @title = "Home"
    @daywods = Daywod.order("performed DESC").paginate(:page => params[:page])
    puts @daywods.inspect
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

  def create_workout
    @wods = Wod.all
  end
  
end
