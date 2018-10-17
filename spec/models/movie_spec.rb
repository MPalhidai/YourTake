require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "when a movie is built" do

    let(:movie) { FactoryBot.create(:movie) }

    it "should be valid" do
      expect(movie.valid?).to be true
    end

    it "should be invalid without an external_id" do
      movie.external_id = nil
      movie.valid?
      expect(movie.errors).to include(:external_id)
    end

    it "should be invalid without a external_rating" do
      movie.external_rating = nil
      movie.valid?
      expect(movie.errors).to include(:external_rating)
    end

    it "should be invalid with a negative rating" do
      movie.external_rating = -1.0
      movie.valid?
      expect(movie.errors).to include(:external_rating)
    end

    it "should be invalid with a rating above 10" do
      movie.external_rating = 11
      movie.valid?
      expect(movie.errors).to include(:external_rating)
    end
  end
end
