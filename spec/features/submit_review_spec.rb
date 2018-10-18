require 'rails_helper'

RSpec.feature "SubmitReview", type: :feature do

  let(:user) { FactoryBot.create(:user) }
  let(:movie) { FactoryBot.create(:movie) }

  scenario "A user can sign in, leave a review, delete review, and log out" do

    visit root_path
    click_link 'Sign in'
    expect(current_path).to eq new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(current_path).to eq root_path
    expect(page).to have_content user.name

    visit movie_path(movie.id)
    expect(page).to have_content movie.title
    expect(page).to have_content 'Write Review'

    visit root_path + 'reviews/new?review[external_id]=' + movie.external_id.to_s
    expect(current_path).to eq new_review_path
    expect(page).to have_content 'Comment'
    expect {
      fill_in 'Rating', with: 99
      fill_in 'Comment', with: "Great!!!"
      click_button 'Post Review'
    }.to change(Review, :count).by(1)

    expect(User.all.count).to eq 1
    expect(Movie.all.count).to eq 1
    expect(Review.all.count).to eq 1

    click_link 'Activity'
    expect(current_path).to eq activity_path
    expect(page).to have_content movie.title
    click_link 'Delete Review'
    expect(Review.all.count).to eq 0

    click_link 'Log Out'
    expect(current_path).to eq root_path
    expect(page).not_to have_content user.name

    visit root_path + 'reviews/new?review[external_id]=' + movie.external_id.to_s
    expect(current_path).to eq new_user_session_path
  end
end
