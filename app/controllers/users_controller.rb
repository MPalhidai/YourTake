class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:activity]

  def activity
    @reviews ||= current_user.get_reviews
  end
end
