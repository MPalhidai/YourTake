require "rails_helper"

RSpec.describe "Review management", :type => :request do

  let(:user) { FactoryBot.create(:user) }
  let(:movie) { FactoryBot.create(:movie) }

  describe "post reviews#create" do
    it "a new review can be created if the user is logged in" do
      sign_in user
      expect {
        post reviews_path, params: { review: { rating: 100, comment: 'Awesome', external_id: movie.external_id, movie_id: movie.id, user_id: user.id } }
      }.to change(Review, :count).by(1)
      expect(response).to redirect_to movie_path(movie.id)
    end

    it "a new review can be created if the user is logged in" do
      expect {
        post reviews_path, params: { review: { rating: 100, comment: 'Awesome', external_id: movie.external_id, movie_id: movie.id, user_id: user.id } }
      }.to change(Review, :count).by(0)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "delete reviews#destroy" do
    it "a review can be destroyed if the user is logged in" do
      sign_in user
      review = FactoryBot.create(:review)
      expect(Review.count).to eq 1

      expect {
        delete review_path(review.id)
      }.to change(Review, :count).by(-1)
      expect(response).to redirect_to activity_path
    end

    it "a review can not be destroyed if the user is not logged in" do
      sign_in user
      review = FactoryBot.create(:review)
      expect(Review.count).to eq 1

      sign_out user
      expect {
        delete review_path(review.id)
      }.to change(Review, :count).by(0)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
