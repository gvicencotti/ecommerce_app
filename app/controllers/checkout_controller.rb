class CheckoutController < ApplicationController
  def create
    @cart = current_user.cart
    @amount = (@cart.cart_items.sum { |item| item.total_price } * 100).to_i

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: @cart.cart_items.map do |item|
        {
          price_data: {
            currency: "brl",
            product_data: {
              name: item.product.name
            },
            unit_amount: (item.product.price * 100).to_i
          },
          quantity: item.quantity
        }
      end,
      mode: "payment",
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
  end

  def cancel
  end
end
