class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart || current_user.create_cart
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: cart_item_params[:product_id])
    @cart_item.quantity ||= 0
    @cart_item.quantity += cart_item_params[:quantity].to_i
    if @cart_item.save
      redirect_to cart_path, notice: "Product added to cart."
    else
      redirect_to products_path, alert: "Unable to add product to cart."
    end
  end

  def update
    @cart_item = current_user.cart.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: "Cart updated."
    else
      redirect_to cart_path, alert: "Unable to update cart."
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: "Product removed from cart."
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
