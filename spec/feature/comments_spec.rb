require 'rails_helper'
require 'pry-byebug'

feature 'Make comment on post', type: :system do
  background 'create user' do
    create(:user)
    Post.create(user_id:User.first.id, title:'something other than next', body: 'again very large probably larger then life in the strong winds')
  end

  scenario 'make a root comment' do
    visit '/users/sign_in'
    fill_in 'Login', with: 'user_1'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit "/user_1/posts/#{User.first.posts.first.id}"

    comment_box = page.find('#comment_body').fill_in with: 'some random comment'
    
    click_on 'Comment'
    expect(page).to have_content('Comment was successfully made.')
  end

  scenario 'make a reply to root comment' do
    fill_in 'Login', with: 'user_2'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit "/user_2/posts/#{User.first.posts.first.id}"

    comment_box = page.find('#comment_body').fill_in with: 'some random comment'
    
    click_on 'Comment'
    click_link 'Reply'

    reply_box = page.find_all('#comment_body').first
    reply_box.fill_in with: 'child of some random comment'
    click_button 'Reply'

    page.assert_selector('.nesting', count: 1)

  end

  scenario 'make two replies to root comment' do
    fill_in 'Login', with: 'user_3'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit "/user_3/posts/#{User.first.posts.first.id}"

    comment_box = page.find('#comment_body').fill_in with: 'some random comment'
    
    click_on 'Comment'
    click_link 'Reply'

    reply_box = page.find_all('#comment_body').first
    reply_box.fill_in with: 'child of some random comment'
    click_button 'Reply'

    expect(page).to have_content('Comment was successfully made.')

    page.find_all('.reply-link').first.click
    
    reply_box2 = page.find_all('#comment_body').first
    reply_box2.fill_in with: 'another child of some random comment'
    page.find 'Reply'

    # page.assert_selector('.nesting', count: 1)
  end
end