require 'rails_helper'

RSpec.feature "ProductManagement", type: :feature do
  scenario "User creates a new product" do
    visit new_product_path

    fill_in "Name", with: "New Product"
    fill_in "Description", with: "A newly added product"
    fill_in "Price", with: "15.99"
    click_button "Create Product"

    expect(page).to have_text("Product was successfully created.")
    expect(page).to have_text("New Product")
    expect(page).to have_text("15.99")
  end

  scenario "User views a product" do
    product = Product.create!(name: "Sample Product", description: "A sample product", price: 9.99)

    visit product_path(product)
    expect(page).to have_text("Sample Product")
    expect(page).to have_text("9.99")
  end
end