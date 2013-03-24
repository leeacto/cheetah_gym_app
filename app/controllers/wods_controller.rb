class WodsController < ApplicationController
  def new
  	@title = "Create New WOD"
    @wod = Wod.new
  end

  def index
  	@title = "List of WODs"
    @wods = Wod.paginate(:page => params[:page])
    @daywod = nil
  end

  def edit
  	@title = "Edit WOD"
  end

  def destroy
    Wod.find(params[:id]).destroy
    flash[:success] = "Wod destroyed."
    redirect_to wods_path
  end

  def show
    @wod = Wod.find(params[:id])
    @title = @wod.name
    @daywods = @wod.daywods.paginate(:page => params[:page])
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
