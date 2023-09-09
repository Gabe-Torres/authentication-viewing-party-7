class MoviesController < ApplicationController
  def index 
      # @user = User.find(params[:id])
      @movies = Movie.all
  end 

  def show
    @movie = Movie.find(params[:id])
    if current_user
      @user = User.find(session[:user_id])
    end
  end
end
