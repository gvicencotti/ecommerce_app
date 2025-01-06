require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do
    it 'is valid with a unique name' do
      category = build(:category)
      expect(category).to be_valid
    end
  end

  it 'is not valid without a name' do
    category = build(:category, name: nil)
    expect(category).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    create(:category, name: 'Electronics')
    category = build(:category, name: 'Electronics')
    expect(category).not_to be_valid
  end

  context 'associations' do
    it 'has many products' do
      category = create(:category)
      product1 = create(:product, category: category)
      product2 = create(:product, category: category)
      expect(category.products).to include(product1, product2)
    end
  end
end
