class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_option, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :user_id, presence: true

  def total_price
    items_total = cart_items.joins(:product).sum("cart_items.quantity * products.price")
    delivery_total = [ delivery_option&.price, 0 ].compact.max
    items_total + delivery_total
  end
end
