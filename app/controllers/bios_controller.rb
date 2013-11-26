class BiosController < ApplicationController

  def create
    params[:height] = params[:bio][:feet]*12 + params[:bio][:inches]
    params[:bio].delete(:feet)
    params[:bio].delete(:inches)
    params[:bio][:user_id] = current_user.id
    @bio = Bio.create(params[:bio])
    redirect_to @bio.user
  end

  def edit
    @bio = Bio.find(params[:id])
  end

  def update
    @bio = Bio.find(params[:id])
    params[:height] = params[:ft]*12 + params[:inches]
    @bio.update_attributes(params[:bio])
    redirect_to users_path(@user)
  end
end
