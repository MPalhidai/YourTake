require "rails_helper"

RSpec.describe "Movie management", :type => :request do

  describe "post movies#create" do
    it "a new movie can be created" do
      expect {
        post movies_path, params: { movie: { title: 'Awesome', external_id: 9999,  external_rating: 10 } }
      }.to change(Movie, :count).by(1)
    end

    it "a new movie can not be created for the same movie" do
      expect {
        post movies_path, params: { movie: { title: 'Awesome', external_id: 9999,  external_rating: 10 } }
      }.to change(Movie, :count).by(1)

      expect {
        post movies_path, params: { movie: { title: 'Awesome', external_id: 9999,  external_rating: 10 } }
      }.to change(Movie, :count).by(0)
    end
  end
end
