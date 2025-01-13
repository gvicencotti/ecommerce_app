require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Product Management', type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:vendor) { create(:user, :vendor) }
  let(:category) { create(:category) }

  before do
    Warden.test_mode!
  end

  after do
    Warden.test_reset!
  end

  scenario 'Admin views the list of products' do
    product = create(:product, category: category, user: vendor)

    login_as(admin, scope: :user)
    visit products_path
    expect(page).to have_content(product.name)
    expect(page).to have_content(number_to_currency(product.price))
    expect(page).to have_content(product.stock)
  end

  scenario 'Vendor creates a new product' do
    product_attributes = attributes_for(:product).merge(category_id: category.id)

    login_as(vendor, scope: :user)
    visit new_product_path

    fill_in 'Name', with: product_attributes[:name]
    fill_in 'Description', with: product_attributes[:description]
    fill_in 'Price', with: product_attributes[:price]
    fill_in 'Stock', with: product_attributes[:stock]
    select category.name, from: 'Category'
    click_button 'Create Product'

    expect(page).to have_content('Product was successfully created.')
    expect(page).to have_content(product_attributes[:name])
    expect(page).to have_content(product_attributes[:description])
    expect(page).to have_content(number_to_currency(product_attributes[:price]))
    expect(page).to have_content(product_attributes[:stock])
  end

  scenario 'Vendor edits a product' do
    product = create(:product, user: vendor, category: category)

    login_as(vendor, scope: :user)
    visit edit_product_path(product)

    fill_in 'Name', with: 'Updated Product'
    fill_in 'Description', with: 'Updated Description'
    fill_in 'Price', with: 20.0
    fill_in 'Stock', with: 10
    select category.name, from: 'Category'
    click_button 'Update Product'

    expect(page).to have_content('Product was successfully updated.')
    expect(page).to have_content('Updated Product')
    expect(page).to have_content('Updated Description')
    expect(page).to have_content(number_to_currency(20.0))
    expect(page).to have_content(10)
  end

  scenario 'Vendor deletes a product' do
    product = create(:product, user: vendor, category: category)

    login_as(vendor, scope: :user)
    visit products_path

    within("#product_#{product.id}") do
      click_link 'Delete'
    end

    expect(page).to have_content('Product was successfully deleted.')
    expect(page).not_to have_content(product.name)
  end

  scenario 'Vendor tries to create a product with invalid inputs' do
    login_as(vendor, scope: :user)
    visit new_product_path

    fill_in 'Name', with: ''
    fill_in 'Price', with: ''
    fill_in 'Stock', with: ''
    click_button 'Create Product'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Stock can't be blank")
  end

  scenario 'Vendor tries to edit a product with invalid inputs' do
    product = create(:product, user: vendor, category: category)

    login_as(vendor, scope: :user)
    visit edit_product_path(product)

    fill_in 'Name', with: ''
    fill_in 'Price', with: ''
    fill_in 'Stock', with: ''
    click_button 'Update Product'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Stock can't be blank")
  end

  scenario 'Non-vendor user tries to create a product' do
    login_as(admin, scope: :user)
    visit new_product_path

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You are not authorized to access this page.')
  end

  scenario 'Non-vendor user tries to edit a product' do
    product = create(:product, user: vendor, category: category)

    login_as(admin, scope: :user)
    visit edit_product_path(product)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You are not authorized to access this page.')
  end
end
