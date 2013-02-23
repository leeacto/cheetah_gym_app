class WodsController < ApplicationController
  def new
  	@title = "Create New WOD"
    @wod = Wod.new
  end

  def index
  	@title = "List of WODs"
    @wods = Wod.paginate(:page => params[:page])
  end

  def edit
  	@title = "Edit WOD"
  end

  def destroy
  end

  def show
    @wod = Wod.find(params[:id])
    @title = @wod.name
  end

  def create
    @wod = Wod.new(params[:wod])
    if @wod.save
      flash[:success] = "New WOD Created"
      redirect_to @wod
    else
      @title = "Create New WOD"
      render 'new'
    end
  end
end
