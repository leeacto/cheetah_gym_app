class ResultsController < ApplicationController
  def new
  	@title = "WOD Result"
  	@wod = Wod.find(params[:wod_id])
  	@daywod = Daywod.find(params[:daywod_id])
  	@result = @daywod.results.new
  end

  def destroy
  end

  def edit
  end

  def create
    @result = Wod.find(params[:wod_id]).daywods.find(params[:daywod_id]).results.build(params[:result])
    if @result.save
      flash[:success] = "Result Logged"
      redirect_to Wod.find(params[:wod_id]).daywods.find(params[:daywod_id])
    else
      render 'new'
    end
  end
end
