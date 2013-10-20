class ResultsController < ApplicationController
  include ResultsHelper

  def new
    @title = "WOD Result"
    @wod = Wod.find(params[:wod_id])
    @daywod = Daywod.find(params[:daywod_id])
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
    @result = Result.find(params[:id])
    @wod = @result.wod
    @daywod = @result.daywod
    if current_user == @result.user
      if @result.update_attributes(params[:result])
        flash[:success] = "Result updated"
        redirect_to wod_daywod_path(@wod, @daywod)
      else
        @title = "Edit Result"
        render 'edit'
      end
    else
      flash[:error] = "Users may only update their own results"
      redirect_to root_path
    end
  end

  def create
    if current_user.admin? || User.find(params[:result][:user_id]) == current_user
      @daywod = Daywod.find(session[:daywod_id])
      @wod = @daywod.wod
      if @wod.wod_type == "Time"
        params[:result][:recd] = time_to_recd(params[:result])
      end
      @result = @daywod.results.build(params[:result])
      if @result.save
        flash[:success] = "Result Logged"
        redirect_to wod_daywod_path(@wod, @daywod)
      else
        flash[:error] = "Result was not saved"
        render 'new'
      end
    else
      flash[:error] = "Only Admins May Add Results for Other Athletes"
      redirect_to root_path
    end
  end
end
