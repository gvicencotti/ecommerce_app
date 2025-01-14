# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def destroy
    super
    flash[:notice] = "Signed out successfully." if is_flashing_format?
  end
end
