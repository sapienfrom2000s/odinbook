require 'rails_helper'

feature 'send message to friends', type: :system do

  background 'create user and friendship association' do
    3.times{ create(:user) }
    FriendRequest.create(sender_id: User.first.id, receiver_id: User.second.id)
    Friendship.create(metadata_id: FriendRequest.first.id)
  end

  scenario 'user able hii message to his friend' do
    log_in_as('user_1')

    sleep 2

    visit message_path('user_2')

    fill_in 'body', with: 'test123'
    click_button 'Send'

    expect(page).to have_content('test123')

    visit destroy_user_session_path

    log_in_as(user_2)
    sleep 2

    visit message_path('user_1')

    expect(page).to have_content('test123')
  end


  scenario 'user forbidden to send message to anyone who is not a friend' do
    log_in_as('user_4')

    sleep 2

    visit message_path('user_6')

    expect(URI.parse(current_path)).to eq('list_friend_page_to_whom_msg_can_be_sent')
  end 
end