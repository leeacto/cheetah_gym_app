class PagesController < ApplicationController
  def home
    @title = "Home"
    @daywods = Daywod.paginate(:page => params[:page]).order("performed DESC")
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
