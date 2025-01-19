require 'rails_helper'

RSpec.feature "User Profile", type: :feature do
  let!(:user) { create(:user) }

  scenario 'User views their profile' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit user_path(user)

    expect(page).to have_content('User Profile')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.created_at.strftime("%B %d, %Y"))
  end

  scenario "User edits their profile" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit edit_user_registration_path
    fill_in 'Street', with: '123 New Street'
    fill_in 'City', with: 'New City'
    fill_in 'State', with: 'New State'
    fill_in 'Zip', with: '12345'
    fill_in 'Country', with: 'New Country'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
  end
end
