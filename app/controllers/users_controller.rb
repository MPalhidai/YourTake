class UsersController < ApplicationController
  def activity
    @reviews = current_user.get_reviews
  end
end
