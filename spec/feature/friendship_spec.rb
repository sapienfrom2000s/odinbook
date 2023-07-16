# frozen_string_literal: true

require 'rails_helper'

describe 'Friend request acceptance', type: :feature do
  it 'when Accept button is clicked' do
    user1 = create(:user)
    create(:user)
    user3 = create(:user)
    create(:user)
    FriendRequest.create(sender_id: user3.id, receiver_id: user1.id)

    visit '/users/sign_in'

    fill_in 'Login', with: 'user_1'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/friendships'

    click_button 'Accept'

    expect(page).to have_content 'FriendRequest successfully accepted'

    click_button 'Remove'

    expect(page).to have_content 'Friendship was successfully destroyed.'
  end
end
