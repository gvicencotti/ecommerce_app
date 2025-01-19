require 'rails_helper'

RSpec.describe 'Product Filtering', type: :feature do
  let!(:category1) { create(:category, name: 'Category 1') }
  let!(:category2) { create(:category, name: 'Category 2') }
  let!(:product1) { create(:product, name: 'Product 1', category: category1, price: 10, stock: 5) }
  let!(:product2) { create(:product, name: 'Product 2', category: category2, price: 20, stock: 0) }
  let!(:product3) { create(:product, name: 'Product 3', category: category1, price: 30, stock: 10) }

  scenario 'User filters products by category' do
    visit products_path

    select 'Category 1', from: 'Category'
    click_button 'Filter'

    expect(page).to have_content('Product 1')
    expect(page).to have_content('Product 3')
    expect(page).not_to have_content('Product 2')
  end

  scenario 'User filters products by price range' do
    visit products_path

    fill_in 'Min Price', with: 15
    fill_in 'Max Price', with: 25
    click_button 'Filter'

    expect(page).to have_content('Product 2')
    expect(page).not_to have_content('Product 1')
    expect(page).not_to have_content('Product 3')
  end

  scenario 'User filters products by stock availability' do
    visit products_path

    check 'In Stock'
    click_button 'Filter'

    expect(page).to have_content('Product 1')
    expect(page).to have_content('Product 3')
    expect(page).not_to have_content('Product 2')
  end

  scenario 'User filters products by category and price range' do
    visit products_path

    select 'Category 1', from: 'Category'
    fill_in 'Min Price', with: 5
    fill_in 'Max Price', with: 15
    click_button 'Filter'

    expect(page).to have_content('Product 1')
    expect(page).not_to have_content('Product 2')
    expect(page).not_to have_content('Product 3')
  end

  scenario 'User filters products by category and stock availability' do
    visit products_path

    select 'Category 1', from: 'Category'
    check 'In Stock'
    click_button 'Filter'

    expect(page).to have_content('Product 1')
    expect(page).to have_content('Product 3')
    expect(page).not_to have_content('Product 2')
  end
end
