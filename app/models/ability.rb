class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    Rails.logger.debug "User role: #{user.role}"

    if user.admin?
      can :manage, :all
      Rails.logger.debug "Admin permissions set"
    elsif user.vendor?
      can :manage, Product, user_id: user.id
      can :read, Product
      Rails.logger.debug "Vendor permissions set"
    else
      can :read, Product
      Rails.logger.debug "Regular user permissions set"
    end
  end
end
