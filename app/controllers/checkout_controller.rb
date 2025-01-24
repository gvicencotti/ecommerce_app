class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def confirm_address
    @address = current_user.address
    unless @address
      redirect_to new_user_address_path(current_user), alert: "Please add an address before proceeding to checkout."
    end
  end

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

    if params[:confirm_address] != "yes"
      redirect_to confirm_address_checkout_path, alert: "Please confirm your delivery address." and return
    end

    _address = current_user.address

    begin
      session = Stripe::Checkout::Session.create({
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
              name: "Standard Delivery"
            },
            unit_amount: (@cart.delivery_option.price * 100).to_i
          },
          quantity: 1
        } ],
        mode: "payment",
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url
      })
      redirect_to session.url, allow_other_host: true
    rescue Stripe::StripeError => e
      flash[:error] = e.message
      redirect_to checkout_confirm_address_path
    end
  end
end
