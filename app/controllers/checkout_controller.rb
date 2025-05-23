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
  
    begin
      line_items = @cart.cart_items.map do |item|
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
      end
  
      line_items << {
        price_data: {
          currency: "usd",
          product_data: {
            name: @cart.delivery_option.name
          },
          unit_amount: (@cart.delivery_option.price * 100).to_i
        },
        quantity: 1
      }
  
      session = Stripe::Checkout::Session.create({
        payment_method_types: ["card"],
        line_items: line_items,
        mode: "payment",
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url,
        customer_email: current_user.email
      })
  
      if session&.url
        redirect_to session.url, allow_other_host: true
      else
        flash[:error] = "There was a problem initiating the checkout session."
        redirect_to cart_path
      end
    rescue Stripe::StripeError => e
      flash[:error] = e.message
      redirect_to cart_path
    end
  end
  
  def success
    @cart = current_user.cart
    @address = current_user.address

    @order = current_user.orders.build(
      address: @address.full_address,
      payment_method: "Credit Card",
      total_price: @cart.cart_items.sum { |item| item.product.price * item.quantity } + @cart.delivery_option.price
    )

    if @order.save
      @cart.cart_items.each do |cart_item|
        @order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          total_price: cart_item.product.price * cart_item.quantity
        )
      end
      @cart.cart_items.destroy_all
      redirect_to @order, notice: "Order was successfully created."
    else
      redirect_to confirm_address_checkout_path, alert: "Order creation failed."
    end
  end

  def cancel
  end
end