class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.total_price = current_user.cart.cart_items.sum { |item| item.product.price * item.quantity }

    if @order.save
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity
        )
      end
      current_user.cart.cart_items.destroy_all
      redirect_to @order, notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:address, :payment_method)
  end
end
