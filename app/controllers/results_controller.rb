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
      redirect_to @wod
    else
      @title = "Edit Result"
      render 'edit'
    end
  end

  def create
    #return unless current_user.admin? == true or params[:user_id] == current_user.id
    @result = Wod.find(params[:wod_id]).daywods.find(params[:daywod_id]).results.build(params[:result])
    if @result.save
      flash[:success] = "Result Logged"
      redirect_to Wod.find(params[:wod_id]).daywods.find(params[:daywod_id])
    else
      render 'new'
    end
  end
end
