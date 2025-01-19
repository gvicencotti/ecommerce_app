class AddDeliveryOptionToCarts < ActiveRecord::Migration[7.2]
  def change
    add_reference :carts, :delivery_option, null: true, foreign_key: true
  end
end
