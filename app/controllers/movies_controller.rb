class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @reviews = Review.all
  end

  def create
    if movie
      redirect_to movie_path(@movie)
    else
      @movie = Movie.new(movie_params)
      if @movie.save
        flash[:notice] = "New movie successfully created."
        redirect_to movie_path(@movie)
      else
        flash.now[:notice] = "Movie was not created."
      end
    end
  end

  def show
    movie
  end

  private

  def movie
    @movie = Movie.find_by(external_id: params[:external_id])
  end

  def movie_params
    params.require(:movie).permit(:title, :external_id, :external_rating)
  end
end
