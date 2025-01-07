class ProductsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
      @products = Product.all
    end

    def show
    end

    def new
      @product = Product.new
    end

    def create
      if @product.save
        redirect_to @product, notice: "Product was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to @product, notice: "Product was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      redirect_to products_url, notice: "Product was successfully deleted."
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :category_id)
    end
end
