require 'rails_helper'

feature 'Make comment on post', type: :system do
  background 'create user' do
    create(:user)
    Post.create(user_id:User.first.id, title:'something other than next', body: 'again very large probably larger then life in the strong winds')
  end

  it 'makes a root comment' do
    log_in_as('user_1')

    sleep 2
    visit post_path('user_1', User.first.posts.first.id)

    comment_box = page.find('#comment_body')
    comment_box.fill_in with: 'some random comment'
    
    click_on 'Comment'
    expect(page).to have_content('Comment was successfully made.')
  end

  it 'make a reply to root comment' do
    log_in_as('user_2')

    sleep 2
    visit "/user_2/posts/#{User.first.posts.first.id}"

    comment_box = page.find('#comment_body').fill_in with: 'some random comment'
    
    click_on 'Comment'
    click_link 'Reply'

    reply_box = page.find_all('#comment_body').first
    reply_box.fill_in with: 'child of some random comment'
    click_button 'Reply'

    page.assert_selector('.nesting', count: 1)

  end

  it 'make two replies to root comment' do
    log_in_as('user_3')

    sleep 2
    visit "/user_3/posts/#{User.first.posts.first.id}"

    comment_box = page.find('#comment_body')
    comment_box.fill_in with: 'some random comment'
    
    click_on 'Comment'
    click_link 'Reply'

    reply_box = page.find_all('#comment_body').first
    reply_box.fill_in with: 'child of some random comment'
    click_button 'Reply'

    expect(page).to have_content('Comment was successfully made.')

    page.find_all('.reply-link a').first.click
    
    reply_box2 = page.find_all('#comment_body').first

    reply_box2.fill_in with: 'another child of some random comment'

    click_button 'Reply'

    page.assert_selector('.nesting', count: 1)
  end

  it 'make two level replies(root --> reply --> reply) to the root comment' do
    log_in_as('user_4')

    sleep 2
    visit "/user_4/posts/#{User.first.posts.first.id}"

    comment_box = page.find('#comment_body').fill_in with: 'some random comment'
    
    click_on 'Comment'
    click_link 'Reply'

    reply_box = page.find_all('#comment_body').first
    reply_box.fill_in with: 'child of some random comment'
    click_button 'Reply'

    expect(page).to have_content('Comment was successfully made.')

    page.find_all('.reply-link a').last.click
    
    reply_box2 = page.find_all('#comment_body').first

    reply_box2.fill_in with: 'grand child of some random comment'

    click_button 'Reply'

    page.assert_all_of_selectors(:css, '.nesting .nesting')
  end
end