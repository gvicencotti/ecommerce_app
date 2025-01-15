require 'rails_helper'

RSpec.describe 'Product Management', type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:vendor1) { create(:user, :vendor) }
  let(:vendor2) { create(:user, :vendor) }
  let(:user) { create(:user) }
  let!(:product1) { create(:product, user: vendor1) }
  let!(:product2) { create(:product, user: vendor2) }

  scenario 'Admin views the list of products' do
    login_as(admin, scope: :user)
    visit products_path

    expect(page).to have_link('New Product')
    expect(page).to have_content(product1.name)
    expect(page).to have_content(product1.description)
    expect(page).to have_content(product1.price)
    expect(page).to have_content(product1.stock)
    expect(page).to have_link('Edit', href: edit_product_path(product1))
    expect(page).to have_link('Delete', href: product_path(product1))

    expect(page).to have_content(product2.name)
    expect(page).to have_content(product2.description)
    expect(page).to have_content(product2.price)
    expect(page).to have_content(product2.stock)
    expect(page).to have_link('Edit', href: edit_product_path(product2))
    expect(page).to have_link('Delete', href: product_path(product2))
  end

  scenario 'Vendor views the list of products' do
    login_as(vendor1, scope: :user)
    visit products_path

    expect(page).to have_link('New Product')
    expect(page).to have_content(product1.name)
    expect(page).to have_content(product1.description)
    expect(page).to have_content(product1.price)
    expect(page).to have_content(product1.stock)
    expect(page).to have_link('Edit', href: edit_product_path(product1))
    expect(page).to have_link('Delete', href: product_path(product1))

    expect(page).to have_content(product2.name)
    expect(page).to have_content(product2.description)
    expect(page).to have_content(product2.price)
    expect(page).to have_content(product2.stock)
    expect(page).not_to have_link('Edit', href: edit_product_path(product2))
    expect(page).not_to have_link('Delete', href: product_path(product2))
  end

  scenario 'Regular user views the list of products' do
    login_as(user, scope: :user)
    visit products_path

    expect(page).not_to have_link('New Product')
    expect(page).to have_content(product1.name)
    expect(page).to have_content(product1.description)
    expect(page).to have_content(product1.price)
    expect(page).to have_content(product1.stock)
    expect(page).not_to have_link('Edit', href: edit_product_path(product1))
    expect(page).not_to have_link('Delete', href: product_path(product1))

    expect(page).to have_content(product2.name)
    expect(page).to have_content(product2.description)
    expect(page).to have_content(product2.price)
    expect(page).to have_content(product2.stock)
    expect(page).not_to have_link('Edit', href: edit_product_path(product2))
    expect(page).not_to have_link('Delete', href: product_path(product2))
  end

  scenario 'Vendor deletes their own product' do
    login_as(vendor1, scope: :user)
    visit products_path

    within("#product_#{product1.id}") do
      click_link 'Delete'
    end

    expect(page).not_to have_content(product1.name)
  end

  scenario 'Admin deletes any product' do
    login_as(admin, scope: :user)
    visit products_path

    within("#product_#{product1.id}") do
      click_link 'Delete'
    end

    expect(page).not_to have_content(product1.name)
  end

  scenario 'Vendor1 can see edit and delete links for their own product, but Vendor2 cannot' do
    login_as(vendor1, scope: :user)
    visit products_path

    expect(page).to have_link('Edit', href: edit_product_path(product1))
    expect(page).to have_link('Delete', href: product_path(product1))
    expect(page).not_to have_link('Edit', href: edit_product_path(product2))
    expect(page).not_to have_link('Delete', href: product_path(product2))

    logout(:user)
    login_as(vendor2, scope: :user)
    visit products_path

    expect(page).to have_link('Edit', href: edit_product_path(product2))
    expect(page).to have_link('Delete', href: product_path(product2))
    expect(page).not_to have_link('Edit', href: edit_product_path(product1))
    expect(page).not_to have_link('Delete', href: product_path(product1))
  end
end
