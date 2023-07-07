require 'rails_helper'

feature 'send message to friends', type: :system do

  background 'create user and friendship association' do
    3.times{ create(:user) }
    FriendRequest.create(sender_id: User.first.id, receiver_id: User.second.id)
    Friendship.create(metadata_id: FriendRequest.first.id)
  end

  it 'user able hii message to his friend' do
    log_in_as('user_1')

    sleep 2

    visit message_index_path('user_2')

    fill_in 'message_body', with: 'test123'
    click_button 'Send'

    expect(page).to have_content('test123')

    visit destroy_user_session_path

    log_in_as('user_2')
    sleep 2

    visit message_index_path('user_1')

    expect(page).to have_content('test123')
  end


  it 'user forbidden to send message to anyone who is not a friend' do
    log_in_as('user_4')

    sleep 2

    visit message_index_path('user_6')
    a = URI.parse(current_path)
    binding.pry

    expect(URI.parse(current_path).to_s).to eq(message_friends_path)
  end 
end