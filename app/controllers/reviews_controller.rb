class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new

  end

  def create

  end

  def index
    @reviews = Review.all
  end

  def show

  end

  def destroy

  end

end
