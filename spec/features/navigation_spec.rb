require 'rails_helper'

RSpec.feature "Navigation", type: :feature do
  let!(:user) { create(:user) }

  scenario "User sees Profile and My Cart links when signed in" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit root_path

    expect(page).to have_link('Profile', href: user_path(user))
    expect(page).to have_link('My Cart', href: cart_path)
    expect(page).to have_button('Logout')
  end

  scenario "User sees Sign Up and Login links when not signed in" do
    visit root_path

    expect(page).to have_link('Sign Up', href: new_user_registration_path)
    expect(page).to have_link('Login', href: new_user_session_path)
  end
end
