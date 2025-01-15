require 'rails_helper'

RSpec.describe 'User Profile', type: :feature do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }

  before do
    login_as(user, scope: :user)
  end

  scenario 'User views their profile' do
    visit user_path(user)

    expect(page).to have_content('User Profile')
    expect(page).to have_content('test@example.com')
    expect(page).to have_content(user.created_at.strftime("%B %d, %Y"))
  end

  scenario 'User edits their profile' do
    visit edit_user_registration_path

    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    visit user_path(user)
    expect(page).to have_content('newemail@example.com')
  end
end
