class Product < ApplicationRecord
    belongs_to :user
    belongs_to :category, optional: true
    has_many :order_items
    has_many :orders, through: :order_items
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
