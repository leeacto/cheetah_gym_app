require 'debugger'
class ResultsController < ApplicationController
  include ResultsHelper

  def index
    if request.xhr?
      @wod = Wod.find(params[:wod_id])
      if @wod.wod_type == "Time"
        @results = Daywod.find(params[:daywod_id]).results.order("rx DESC, recd ASC")
      else
        @results = Daywod.find(params[:daywod_id]).results.order("rx DESC, recd DESC")
      end
      render 'index', { :layout => false}
    else
      @results = Daywod.find(params[:daywod_id]).results
    end
  end

  def new
    @title = "WOD Result"
    @wod = Wod.find(params[:wod_id])
    @daywod = Daywod.find(params[:daywod_id])
    @result = @daywod.results.new
    session[:daywod_id] = @daywod.id
  end

  def create
    if current_user.admin? || current_user?(User.find(params[:result][:user_id]))
      @daywod = Daywod.find(session[:daywod_id])
      @wod = @daywod.wod
      
      if @wod.wod_type == "Time"
        params[:result][:recd] = time_to_recd(params[:result]) 
        params[:result].delete(:mins)
        params[:result].delete(:secs)
      elsif @wod.baserep > 1
        params[:result][:recd] = rds_to_recd(params[:result], @wod.baserep)
        params[:result].delete(:rds)
        params[:result].delete(:reps)
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

  def destroy
    @result = Result.find(params[:id])
    @daywod = @result.daywod
    @wod = @result.wod
    if signed_in? && (current_user?(@result.user) || current_user.admin)
      @result.destroy
    else
      flash[:error] = "You can only delete your own result"
    end
      redirect_to wod_daywod_path(@wod, @daywod)
  end

  def edit
    @title = "Edit Result"
    @result = Result.find(params[:id])
    @wod = @result.wod
    @daywod = @result.daywod
  end

  def update
    @result = Result.find(params[:id])
    @wod = @result.wod
    @daywod = @result.daywod
    if current_user.admin || current_user?(@result.user)
      params[:result][:recd] = time_to_recd(params[:result]) if @wod.wod_type == "Time"
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
end
