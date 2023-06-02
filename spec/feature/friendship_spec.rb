
require 'pry-byebug'
require "rails_helper"

describe "Friend request acceptance", type: :feature do
  it "when Accept button is clicked" do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    FriendRequest.create(sender_id:user3.id, receiver_id:user1.id)


    visit '/users/sign_in'

    fill_in 'Login', with: 'user_1'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    click_button 'Accept'

    expect(page).to have_content "Friendship was successfully created."

    click_button 'Remove'

    expect(page).to have_content "Friendship was successfully destroyed."
  end
 end