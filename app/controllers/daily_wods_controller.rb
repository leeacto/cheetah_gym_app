class DailyWodsController < ApplicationController
  def new
    #@wod = Wod.find(params[:id])
    @title = "New Daily Wod - @wod" 
  end

  def edit
  end

  def destroy
  end

  def show
  end

  def create
    @dwod = current_wod.daily_wods.build(params[:daily_wod])
    if @dwod.save
      flash[:success] = "Daily WOD created!"
      redirect_to current_wod
    else
      render 'new'
    end
  end
end
