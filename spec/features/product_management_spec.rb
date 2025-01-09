require 'rails_helper'

RSpec.describe 'Product Management', type: :feature do
  include ActionView::Helpers::NumberHelper

  let(:admin) { create(:user, :admin) }
  let(:vendor) { create(:user, :vendor) }

  before do
    Warden.test_mode!
  end

  after do
    Warden.test_reset!
  end

  scenario 'Admin views the list of products' do
    product = create(:product)

    login_as(admin, scope: :user)
    visit products_path
    expect(page).to have_content(product.name)
    expect(page).to have_content(number_to_currency(product.price))
    expect(page).to have_content(product.stock)
  end

  scenario 'Vendor creates a new product' do
    category = create(:category)
    product_attributes = attributes_for(:product).merge(category_id: category.id)

    login_as(vendor, scope: :user)
    visit new_product_path

    fill_in 'Name', with: product_attributes[:name]
    fill_in 'Description', with: product_attributes[:description]
    fill_in 'Price', with: product_attributes[:price]
    fill_in 'Stock', with: product_attributes[:stock]
    select category.name, from: 'Category'
    click_button 'Create Product'

    expect(page).to have_content('Product created successfully!')
    expect(page).to have_content(product_attributes[:name])
    expect(page).to have_content(product_attributes[:description])
    expect(page).to have_content(number_to_currency(product_attributes[:price]))
    expect(page).to have_content(product_attributes[:stock])
  end

  scenario 'Vendor edits a product' do
    product = create(:product, user: vendor)

    login_as(vendor, scope: :user)
    visit edit_product_path(product)

    fill_in 'Name', with: 'Updated Product Name'
    click_button 'Update Product'

    expect(page).to have_content('Product was successfully updated.')
    expect(page).to have_content('Updated Product Name')
  end

  scenario 'Vendor deletes a product' do
    product = create(:product, user: vendor)

    login_as(vendor, scope: :user)
    visit products_path
    click_link 'Delete', href: product_path(product)

    expect(page).to have_content('Product was successfully deleted.')
    expect(page).not_to have_content(product.name)
  end
end
