class Address < ApplicationRecord
  belongs_to :user

  validates :cep, :street, :neighborhood, :city, :state, presence: true

  def full_address
    "#{street}, #{neighborhood}, #{city}, #{state}, #{cep}"
  end

  def calculate_freight
    case state
    when "SP" then 10.00
    when "RJ" then 15.00
    else 20.00
    end
  end
end
