class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @review = current_user.reviews.build(review_params)
    @review.movie_id = find_movie

    if @review.save
      flash[:notice] = "Review successfully posted for #{@review.movie.title}."
      redirect_to @movie
    else
      flash[:notice] = "Review unsuccessfully saved. Please try again."
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
    @movie ||= Movie.find_by(external_id: params[external_id])
  end

  def review
    @review ||= Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating, :external_id)
  end

end
