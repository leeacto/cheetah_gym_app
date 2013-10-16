class ResultsController < ApplicationController
  include ResultsHelper

  def new
    @title = "WOD Result"
    @wod = Wod.find(params[:wod_id])
    @daywod = Daywod.find(params[:daywod_id])
    @cuser = current_user
    @result = @daywod.results.new
    session[:daywod_id] = @daywod.id
  end

  def destroy
  end

  def edit
    @title = "Edit Result"
    @wod = Wod.find(params[:wod_id])
    @daywod = Daywod.find(params[:daywod_id])
    @result = @daywod.results.find(params[:id])
  end

  def update
    @wod = Wod.find(params[:wod_id])
    @daywod = Daywod.find(params[:daywod_id])
    @result = @daywod.results.find(params[:id])
    if @result.update_attributes(params[:result])
      flash[:success] = "Result updated"
      redirect_to Wod.find(params[:wod_id]).daywods.find(params[:daywod_id])
    else
      @title = "Edit Result"
      render 'edit'
    end
  end

  def create
    @daywod = Daywod.find(session[:daywod_id])
    @wod = @daywod.wod

    #Change Mins to Secs if WOD is Timed
    if @wod.wod_type == "Time"
      params[:result][:recd] = time_to_recd(params[:result])
    end
    #Save Result
    @result = @daywod.results.build(params[:result])
    if @result.save
      flash[:success] = "Result Logged"
      redirect_to wod_daywod_path(@wod, @daywod)
    else
      render 'new'
    end
  end
end
