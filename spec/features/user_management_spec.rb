require 'rails_helper'

RSpec.describe 'User Management', type: :feature do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }

  scenario 'User registers' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'User logs in' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'User logs out' do
    login_as(user, scope: :user)

    visit root_path
    click_button 'Logout'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
