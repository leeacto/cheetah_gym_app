class DaywodsController < ApplicationController
  def new
    @wod = Wod.find(params[:wod_id])
    @title = "New Daily Wod - #{@wod.name}"
    @daywod = @wod.daywods.new
  end

  def edit
    @daywod = Daywod.find(params[:id])
    @title = "Edit Daywod"
  end

  def update
    @wod = Wod.find(params[:wod_id])
    @daywod = Daywod.find(params[:id])
    if @daywod.update_attributes(params[:daywod])
      flash[:success] = "Daywod updated"
      redirect_to @wod
    else
      @title = "Edit Daywod"
      render 'edit'
    end
  end

  def destroy
    @wod = Daywod.find(params[:id]).wod_id
    Daywod.find(params[:id]).destroy
    redirect_to Wod.find(@wod)
  end

  def show
    @daywod = Daywod.find(params[:id])
    @wod = @daywod.wod
    @title = @wod.name
    if @wod.wod_type == "Time"
      @results = @daywod.results.paginate(:page => params[:page]).order("rx DESC, recd ASC")
    else
      @results = @daywod.results.paginate(:page => params[:page]).order("rx DESC, recd DESC")
    end
  end

  def create
    @daywod = Daywod.new(params[:daywod])
    @daywod.update_attributes(:wod_id => params[:wod_id])
    @wod = Wod.find(params[:wod_id])
    if @daywod.save
      flash[:success] = "Daily WOD created!"
      redirect_to Daywod.find(@daywod)
    else
      render 'new'
    end
  end
end
