require 'rails_helper'

RSpec.describe 'Category Management', type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  before do
    Warden.test_mode!
  end

  after do
    Warden.test_reset!
  end

  scenario 'User views the list of categories' do
    create(:category, name: 'Electronics')
    create(:category, name: 'Home Appliances')

    login_as(admin, scope: :user)
    visit categories_path
    expect(page).to have_content('Electronics')
    expect(page).to have_content('Home Appliances')
  end

  scenario 'User creates a new category' do
    login_as(admin, scope: :user)
    visit new_category_path

    fill_in 'Name', with: 'Fashion'
    click_button 'Create Category'

    expect(page).to have_content('Category was successfully created.')
    expect(page).to have_content('Fashion')
  end

  scenario 'User edits a category' do
    category = create(:category, name: 'Gadgets')

    login_as(admin, scope: :user)
    visit edit_category_path(category)

    fill_in 'Name', with: 'Updated Gadgets'
    click_button 'Update Category'

    expect(page).to have_content('Category was successfully updated.')
    expect(page).to have_content('Updated Gadgets')
  end

  scenario 'User deletes a category' do
    category = create(:category, name: 'Gadgets')

    login_as(admin, scope: :user)
    visit categories_path

    within("#category_#{category.id}") do
      click_link 'Delete'
    end

    expect(page).to have_content('Category was successfully destroyed.')
    expect(page).not_to have_content('Gadgets')
  end

  scenario 'User tries to create a category with invalid inputs' do
    login_as(admin, scope: :user)
    visit new_category_path

    fill_in 'Name', with: ''
    click_button 'Create Category'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'User tries to edit a category with invalid inputs' do
    category = create(:category, name: 'Gadgets')

    login_as(admin, scope: :user)
    visit edit_category_path(category)

    fill_in 'Name', with: ''
    click_button 'Update Category'

    expect(page).to have_content("Name can't be blank")
  end
end
