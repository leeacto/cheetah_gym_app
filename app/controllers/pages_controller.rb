class PagesController < ApplicationController
  def home
    @title = "Home"
    @daywods = Daywod.impersonal.order("performed DESC").current.paginate(:page => params[:page])
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
