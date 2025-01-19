require 'rails_helper'

RSpec.describe DeliveryOption, type: :model do
  it "is valid with valid attributes" do
    delivery_option = DeliveryOption.new(name: "Standard Delivery", price: 5.00)
    expect(delivery_option).to be_valid
  end

  it "is invalid without a name" do
    delivery_option = DeliveryOption.new(name: nil, price: 5.00)
    expect(delivery_option).not_to be_valid
  end

  it "is invalid without a price" do
    delivery_option = DeliveryOption.new(name: "Standard Delivery", price: nil)
    expect(delivery_option).not_to be_valid
  end

  it "is invalid with a negative price" do
    delivery_option = DeliveryOption.new(name: "Standard Delivery", price: -5.00)
    expect(delivery_option).not_to be_valid
  end
end
