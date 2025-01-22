class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_admin, only: [ :index, :destroy ]

  def index
    @users = User.all
  end

  def show
    @address = @user.address || @user.build_address
  end

  def new
    @user = User.new
  end

  def edit
    @address = @user.address || @user.build_address
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted_params = [ :email, :password, :password_confirmation, address_attributes: [ :id, :cep, :street, :neighborhood, :city, :state ] ]
    permitted_params << :role if current_user.admin?
    params.require(:user).permit(permitted_params)
  end

  def authorize_admin
    redirect_to(root_path, alert: "Not authorized") unless current_user.admin?
  end
end
