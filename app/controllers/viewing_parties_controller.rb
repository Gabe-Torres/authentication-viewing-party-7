class ViewingPartiesController < ApplicationController 
  include SessionHelper

  before_action :logged_in?, only: [:new, :create]

  def new
    @movie = Movie.find(params[:movie_id])
  end 
  
  def create 
    @movie = Movie.find(params[:movie_id])
    if current_user 
      viewing_party = current_user.viewing_parties.create(viewing_party_params)
      redirect_to "/dashboard"
    else 
      flash[:error] = "You must be logged in or registered to create a viewing party.'"
      redirect_to movie_path(@movie)
    end
  end 

  private

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 