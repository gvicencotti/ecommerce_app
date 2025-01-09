class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @users = User.all
  end

  def update_role
    user = User.find(params[:id])
    if user.update(role_params)
      redirect_to users_path, notice: "#{user.email} is now a #{user.role}!"
    else
      redirect_to users_path, alert: "Failed to update role."
    end
  end

  private

  def role_params
    params.require(:user).permit(:role)
  end

  def admin_only
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
  end
end
