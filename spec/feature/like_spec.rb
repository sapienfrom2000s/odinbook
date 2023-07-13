require 'rails_helper'

feature 'user can like posts', type: :feature do
  background 'log in user' do
    create(:user)
    create(:user)
    Post.create(user_id:User.first.id, title:'something other than next', body: 'again very large probably largler then life in the strong winds')
    Post.create(user_id:User.first.id, title:'something other than next', body: 'again very large probably largler then life in the strong winds')
    Post.create(user_id:User.last.id, title:'something other than next', body: 'again very large probably largler then life in the strong winds')
    Post.create(user_id:User.last.id, title:'something other than next', body: 'again very large probably largler then life in the strong winds')
    visit '/users/sign_in'
  end

  scenario 'likes his post' do
    fill_in 'Login', with: 'user_1'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_1/posts/'
    expect{ all(:button, 'Like').first.click }.to change{all(:css, '.likes_count').first.text[-1].to_i}  
  end

  scenario 'unlikes his post' do
    fill_in 'Login', with: 'user_3'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_3/posts/'
    all(:button, 'Like').first.click 
    expect{ all(:button, 'Unlike').first.click }.to change{all(:css, '.likes_count').first.text[-1].to_i}.by(-1)
  end

  scenario 'does not affect other posts' do
    fill_in 'Login', with: 'user_5'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_5/posts/'
    expect{ all(:button, 'Like').first.click }.to change{all(:css, '.likes_count').last.text[-1].to_i}.by(0)  
  end

  scenario 'likes other user post' do
    fill_in 'Login', with: 'user_7'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_8/posts/'
    expect{ all(:button, 'Like').first.click }.to change{all(:css, '.likes_count').first.text[-1].to_i}
  end

  scenario 'unlikes other user post' do
    fill_in 'Login', with: 'user_9'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_10/posts/'
    all(:button, 'Like').first.click 
    expect{ all(:button, 'Unlike').first.click }.to change{all(:css, '.likes_count').first.text[-1].to_i}.by(-1)
  end

  scenario 'does not affect likes of other user post' do
    fill_in 'Login', with: 'user_11'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_12/posts/'
    expect{ all(:button, 'Like').first.click }.to change{all(:css, '.likes_count').last.text[-1].to_i}.by(0)  
  end
end
