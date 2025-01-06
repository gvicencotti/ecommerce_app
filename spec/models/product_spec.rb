require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      product = create(:product)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = build(:product, name: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without a price' do
      product = build(:product, price: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without a stock' do
      product = build(:product, stock: nil)
      expect(product).not_to be_valid
    end
  end
end
