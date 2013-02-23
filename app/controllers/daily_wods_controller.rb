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
    @dwod = DailyWod.new(params[:daily_wod])
    if @dwod.save
      flash[:success] = "Daily WOD Created"
      redirect_to @dwod
    else
      @title = "New Daily Wod - @wod"
      render 'new'
    end
  end
end
