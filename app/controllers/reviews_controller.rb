class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @review = current_user.reviews.build(review_params)
    find_movie
    if !@movie
      flash[:notice] = "Please add the movie by clicking on the title."
      redirect_to root_path
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    find_movie

    if @review.save
      flash[:notice] = "Review successfully posted for #{@review.movie.title}."
      redirect_to @movie
    else
      flash[:notice] = "Review unsuccessfully saved. Please try again."
      redirect_to root_path
    end
  end

  def index
    @reviews = Review.all
  end

  def show
    review
  end

  def destroy
    review.destroy
    flash[:notice] = "Your review of #{@review.movie.title} was successfully removed."
  end

  private

  def find_movie
    @movie = Movie.find_by(external_id: @review.external_id)
  end

  def review
    @review ||= Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating, :external_id, :movie_id)
  end

end
