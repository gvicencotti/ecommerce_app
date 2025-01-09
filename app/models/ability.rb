class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.vendor?
      can :manage, Product, user_id: user.id
      can :read, Product
    else
      can :read, Product
      can :read, Category
    end
  end
end
