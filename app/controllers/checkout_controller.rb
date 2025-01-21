class CheckoutController < ApplicationController
  def create
    @cart = current_user.cart
    delivery_option_id = params.dig(:cart, :delivery_option_id)
    if delivery_option_id.present?
      @cart.update(delivery_option_id: delivery_option_id)
    end

    if @cart.delivery_option.nil?
      flash[:alert] = "Please select a delivery option."
      redirect_to cart_path and return
    end

    @amount = (@cart.total_price * 100).to_i

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: @cart.cart_items.map do |item|
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: item.product.name
            },
            unit_amount: (item.product.price * 100).to_i
          },
          quantity: item.quantity
        }
      end + [ {
        price_data: {
          currency: "usd",
          product_data: {
            name: @cart.delivery_option.name
          },
          unit_amount: (@cart.delivery_option.price * 100).to_i
        },
        quantity: 1
      } ],
      mode: "payment",
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
      shipping_address_collection: {
        allowed_countries: [ "US", "CA", "BR" ]
      }
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
  end

  def cancel
  end
end
