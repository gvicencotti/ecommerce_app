class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_category, only: [ :show, :edit, :update, :destroy ]
  def index
    @categories = Category.all
  end

  def show
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: "Category was successfully deleted."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def admin_only
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user&.admin?
  end
end
