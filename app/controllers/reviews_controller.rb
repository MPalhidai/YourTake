class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = current_user.review.build(review_params)
    if @review
      flash[:notice] = "Review successfully posted ${@review.movie.title}."
      redirect_to movie_path(@review.movie.id)
    else
      flash[:notice] = "Review unsuccessfully saved. Please try again."
      render :new
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
    flash[:notice] = "Your review of ${@review.movie.title} was successfully removed."
  end

  private

  def review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end
