require 'pry-byebug'

module LoginHelper
  def log_in_as(user)
    visit '/users/sign_in'
    fill_in 'Password', with: 'password'
    fill_in 'Login', with: user
    
    click_button 'Log in'
  end
end