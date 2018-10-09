class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def create
    # find by external_id or create
    @movie = Movie.create(title: ' ', external_id: ' ')
    if @movie
      flash[:notice] = "New movie successfully created."
      redirect_to :show
    else
      flash[:notice] = "Movie was not created."
      redirect_to :index
    end
  end

  def show
    @movie = Movie.find_by(external_id: ' ')
  end
end
