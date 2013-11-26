class BiosController < ApplicationController

  def edit
    @bio = Bio.find(params[:id])
  end

  def update
    @bio = Bio.find(params[:id])
    @bio = @bio.user
    params[:bio][:height] = params[:bio][:feet].to_i*12 + params[:bio][:inches].to_i
    params[:bio].delete(:feet)
    params[:bio].delete(:inches)
    @bio.update_attributes(params[:bio])
    redirect_to users_path(@user)
  end

  private
  def bio_attributes
    params.require(:bio).permit(:height, :weight, :fav, :unfav, :experience)
  end
end
