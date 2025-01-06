require 'rails_helper'

RSpec.describe 'Product Management', type: :feature do
  include ActionView::Helpers::NumberHelper

  scenario 'User views the list of products' do
    product = create(:product)

    visit products_path
    expect(page).to have_content(product.name)
    expect(page).to have_content(number_to_currency(product.price))
    expect(page).to have_content(product.stock)
  end

  scenario 'User creates a new product' do
    category = create(:category)
    product_attributes = attributes_for(:product).merge(category_id: category.id)

    visit new_product_path

    fill_in 'Name', with: product_attributes[:name]
    fill_in 'Description', with: product_attributes[:description]
    fill_in 'Price', with: product_attributes[:price]
    fill_in 'Stock', with: product_attributes[:stock]
    select category.name, from: 'Category'
    click_button 'Save Product'

    expect(page).to have_content('Product was successfully created.')
    expect(page).to have_content(product_attributes[:name])
  end
end
