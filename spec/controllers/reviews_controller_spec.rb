require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "#new" do
    it "if user is logged in and movie does not exist" do
      get :new, params: { review: { rating: 99, comment: "great", external_id: 1, user_id: user.id, movie_id: 1 } }
      expect(response).to redirect_to(root_path)
    end

    it "if user is not logged in" do
      sign_out user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#create" do
    it "if user is logged out" do
      sign_out user
      get :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#destroy" do
    it "if user is logged out" do
      sign_out user
      get :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
