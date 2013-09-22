class WodsController < ApplicationController
  def new
  	@title = "Create New WOD"
    @wod = Wod.new
  end
  
  def index
  	@title = "List of WODs"
    @wods = Wod.search(params[:search]).paginate(:page => params[:page])
    @daywod = nil
  end

  def edit
    @wod = Wod.find(params[:id])
    @title = @wod.name
  end

  def update
    @wod = Wod.find(params[:id])
    if @wod.update_attributes(params[:wod])
      flash[:success] = "Profile updated"
      redirect_to @wod
    else
      @title = "Edit WOD"
      render 'edit'
    end
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
    @athletes = @wod.athletes.uniq
    if request.xhr?
      render json: @wod
    else
      render 'show'
    end
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
