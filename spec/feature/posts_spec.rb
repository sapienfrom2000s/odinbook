# frozen_string_literal: true

require 'rails_helper'
require 'pry-byebug'

feature 'create, modify, access posts', type: :feature do
  background 'log in user' do
    create(:user)
    create(:user)
    visit '/users/sign_in'
  end

  scenario 'creates post if validation passes and is authorized' do
    fill_in 'Login', with: 'user_1'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_1/posts/new'

    fill_in 'Title', with: 'This is more than 10 characters'
    fill_in 'Body', with: 'I know you wont believe but this is more than 30 characters long'
    click_button 'Create Post'

    expect(page).to have_content 'Post was successfully created.'

    click_link 'Edit this post'

    fill_in 'Title', with: 'You are being updated'
    click_button 'Update Post'

    expect(page).to have_content 'Post was successfully updated.'
    expect(page).to have_content 'You are being updated'
    expect(page).to_not have_content 'This is more than 10 characters'

    click_button 'Destroy this post'
  end

  scenario 'shows index and show page of other users' do
    fill_in 'Login', with: 'user_3'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_3/posts/new'

    fill_in 'Title', with: 'This is more than 10 characters'
    fill_in 'Body', with: 'I know you wont believe but this is more than 30 characters long'
    click_button 'Create Post'

    visit '/'

    click_link 'Log Out'

    expect(page).to_not have_content 'This is more than 10 characters'

    fill_in 'Login', with: 'user_4'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_3/posts'

    expect(page).to have_content 'This is more than 10 characters'

    click_link 'Show this post'

    expect(page).to have_content 'I know you wont believe but this is more than 30 characters long'
  end

  scenario 'redirects if current_user tries to access page other than show or index of other user' do
    fill_in 'Login', with: 'user_5'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_5/posts/new'

    fill_in 'Title', with: 'This is more than 10 characters'
    fill_in 'Body', with: 'I know you wont believe but this is more than 30 characters long'
    click_button 'Create Post'

    visit '/'

    click_link 'Log Out'

    fill_in 'Login', with: 'user_6'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/user_5/posts/new'

    expect(page).to have_content 'You cannot access that page'

    visit '/user_5/posts/1/edit'

    expect(page).to have_content 'You cannot access that page'
  end
end
