# frozen_string_literal: true

require 'rails_helper'

feature 'Send Friend Request', type: :feature do
  scenario 'when Accept button is clicked' do
    create(:user)
    create(:user)

    visit '/users/sign_in'

    fill_in 'Login', with: 'user_1'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/find_friends'

    click_button 'Send FR'

    expect(page).to have_content 'Friend Request was successfully sent.'

    click_button 'Cancel'

    expect(page).to have_content 'Friend request was retracted.'
  end
end
