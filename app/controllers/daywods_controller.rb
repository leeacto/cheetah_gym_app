class DaywodsController < ApplicationController
  def new
    @wod = Wod.find(params[:wod_id])
    @title = "New Daily Wod - #{@wod.name}"
    @daywod = @wod.daywods.new
  end

  def edit
  end

  def destroy
    @wod = Daywod.find(params[:id]).wod_id
    Daywod.find(params[:id]).destroy
    redirect_to Wod.find(@wod)
  end

  def show
    @wod = Wod.find(Daywod.find(params[:id]).wod_id)
    @daywod = Daywod.find(params[:id])
    @title = Wod.find(@wod).name
    if @wod.wod_type == "Time"
      @results = Daywod.find(params[:id]).results.paginate(:page => params[:page]).order("rx DESC, recd ASC")
    else
      @results = Daywod.find(params[:id]).results.paginate(:page => params[:page]).order("rx DESC, recd DESC")
    end
  end

  def create
    
    @daywod = Wod.find(params[:wod_id]).daywods.build(params[:daywod])
    if @daywod.save
      flash[:success] = "Daily WOD created!"
      redirect_to Wod.find(params[:wod_id])
    else
      render 'new'
    end
  end
end
