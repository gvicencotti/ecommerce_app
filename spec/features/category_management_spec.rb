require 'rails_helper'

RSpec.describe 'Category Management', type: :feature do
  scenario 'User views the list of categories' do
    create(:category, name: 'Electronics')
    create(:category, name: 'Home Appliances')

    visit categories_path
    expect(page).to have_content('Electronics')
    expect(page).to have_content('Home Appliances')
  end

  scenario 'User creates a new category' do
    visit new_category_path

    fill_in 'Name', with: 'Fashion'
    click_button 'Create Category'

    expect(page).to have_content('Category was successfully created.')
    expect(page).to have_content('Fashion')
  end

  scenario 'User edits a category' do
    category = create(:category, name: 'Gadgets')

    visit edit_category_path(category)
    fill_in 'Name', with: 'Tech Gadgets'
    click_button 'Update Category'

    expect(page).to have_content('Category was successfully updated.')
    expect(page).to have_content('Tech Gadgets')
  end

  scenario 'User deletes a category' do
    category = create(:category, name: 'Obsolete Items')

    visit categories_path
    click_link 'Delete', href: category_path(category)

    expect(page).to have_content('Category was successfully deleted.')
    expect(page).not_to have_content('Obsolete Items')
  end
end
