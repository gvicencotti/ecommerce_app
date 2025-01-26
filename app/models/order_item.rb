class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_save :set_total_price

  def total_price
    product.price * quantity
  end

  private

  def set_total_price
    self.total_price = total_price
  end
end
