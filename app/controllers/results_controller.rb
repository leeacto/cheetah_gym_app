class ResultsController < ApplicationController

  def new
  	@title = "WOD Result"
  	@wod = Wod.find(params[:wod_id])
  	@daywod = Daywod.find(params[:daywod_id])
    @cuser = current_user
  	@result = @daywod.results.new
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
    @cuser = current_user
    @daywod = Wod.find(params[:wod_id]).daywods.find(params[:daywod_id])
    @wod = Wod.find(params[:wod_id])
    #Change Mins to Secs if WOD is Timed
    if @wod.wod_type == "Time"
      params[:result][:recd] = params[:result][:mins].to_i*60 + params[:result][:secs].to_i
    end
    #Save Result
    @result = Wod.find(params[:wod_id]).daywods.find(params[:daywod_id]).results.build(params[:result])
    if @result.save
      flash[:success] = "Result Logged"
      redirect_to @daywod
    else
      render 'new'
    end
  end
end
