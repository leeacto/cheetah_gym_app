class BiosController < ApplicationController

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
