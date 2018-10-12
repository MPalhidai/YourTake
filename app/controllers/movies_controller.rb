class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @reviews = Review.all
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "New movie successfully created."
      redirect_to @movie
    else
      flash.now[:notice] = "Movie was not created."
    end
  end

  def show
    @movie ||= Movie.find(params[:id])
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :external_id, :external_rating)
  end
end
