class DaywodsController < ApplicationController
  def new
    @wod = Wod.find(params[:wod_id])
    @title = "New Daily Wod - #{@wod.name}"
    @daywod = @wod.daywods.new
  end

  def edit
  end

  def destroy
  end

  def show
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
