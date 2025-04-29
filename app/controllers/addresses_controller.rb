class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:new, :create, :edit, :update]

  def new
    @address = current_user.build_address
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save
      redirect_to user_path(current_user), notice: "Address saved successfully."
    else
      render :new
    end
  end

  def edit
    @address = current_user.address
  end

  def update
    @address = current_user.address
    if @address.update(address_params)
      redirect_to user_path(current_user), notice: "Address updated successfully."
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:cep, :street, :neighborhood, :city, :state)
  end

  def authorize_user!
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Please log in."
    elsif !(current_user.admin? || current_user == User.find(params[:user_id]))
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end