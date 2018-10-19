require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "#activity" do
    it "if user is not logged in" do
      sign_out user
      get :activity
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
