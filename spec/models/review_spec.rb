require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "when a review is built" do

    let(:review) { FactoryBot.create(:review) }

    it "should be valid" do
      expect(review.valid?).to be true
    end

    it "should be invalid without a user" do
      review.user = nil
      review.valid?
      expect(review.errors).to include(:user)
    end

    it "should be invalid without a movie" do
      review.movie = nil
      review.valid?
      expect(review.errors).to include(:movie)
    end

    it "should be invalid without a rating" do
      review.rating = nil
      review.valid?
      expect(review.errors).to include(:rating)
    end

    it "should be invalid with a rating above 100" do
      review.rating = 101
      review.valid?
      expect(review.errors).to include(:rating)
    end

    it "should be invalid with a rating below 0" do
      review.rating = -1
      review.valid?
      expect(review.errors).to include(:rating)
    end

    it "should be invalid without a comment" do
      review.comment = nil
      review.valid?
      expect(review.errors).to include(:comment)
    end

    it "should be invalid with a comment of all whitespace" do
      review.comment = "            "
      review.valid?
      expect(review.errors).to include(:comment)
    end
  end
end
