require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  describe "#index" do
    it "returns all movies" do

    end

    it "returns all reviews" do

    end
  end

  describe "#create" do
    it "user can add movie to db" do

    end

    it "can't add movie if already in db" do

    end
  end

  describe "#show" do
    it "returns movie if movie exists" do

    end

    it "returns nil if movie doesn't exists" do

    end
  end

  describe "#list" do
    it "returns a sorted list of movies by number of reviews decreasing" do

    end

    it "returns all movies in reverse" do

    end
  end

end
