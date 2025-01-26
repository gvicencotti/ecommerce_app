class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :address, presence: true
  validates :payment_method, presence: true

  def total_price
    order_items.sum(&:total_price)
  end
end
