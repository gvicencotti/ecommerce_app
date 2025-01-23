require 'rails_helper'

RSpec.describe Address, type: :model do
  it "is valid with valid attributes" do
    user = FactoryBot.create(:user)
    address = FactoryBot.build(:address, user: user)
    expect(address).to be_valid
  end

  it "is not valid without a cep" do
    user = FactoryBot.create(:user)
    address = FactoryBot.build(:address, user: user, cep: nil)
    expect(address).not_to be_valid
  end
end
