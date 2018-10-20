require 'rails_helper'

RSpec.feature "AddMovie", type: :feature do

  let(:user) { FactoryBot.create(:user) }

  scenario "A user can add a movie that does not exist", js: true do
    visit root_path
    expect(Movie.count).to be 0
    expect(page).to have_content '★★★★'
    first('button.movie_card_title').click
    sleep(3)
    expect(Movie.count).to be 1
    expect(current_path).to eq(list_path)

    find('.fa-home').click
    find('#search-input').set('Kung Fu Panda').native.send_keys(:return)
    sleep(3)
    expect(page).to have_content 'Family'
    first('button.movie_card_title').click
    sleep(3)
    expect(Movie.count).to be 2

    find('.fa-home').click
    find('#search-input').set('Kung Fu Panda').native.send_keys(:return)
    sleep(3)
    first('button.movie_card_title').click
    sleep(3)
    expect(Movie.count).to be 2
    expect(current_path).to eq(list_path)

    find('.fa-home').click
    find('#search-input').set('Top Gun').native.send_keys(:return)
    sleep(3)
    expect(page).to have_content 'Action'
    first('button.movie_card_title').click
    sleep(3)
    expect(Movie.count).to be 3
    expect(current_path).to eq(list_path)
    find('.fa-home').click
    find('#search-input').set('Top Gun').native.send_keys(:return)
    first('.movie_card_leave_review').click
    expect(current_path).to eq(new_user_session_path)

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    fill_in 'Rating', with: 97
    fill_in 'Comment', with: 'Great!'
    click_button 'Post Review'
    expect(Review.count).to be 1

    find('.fa-home').click
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'More Movies'
    click_button 'More Movies'
    sleep(3)
    expect(page).to have_text(/★★★★/, minimum: 20)
    click_button 'Release Date'
    sleep(3)
    expect(page).to have_content '2018'
  end
end
