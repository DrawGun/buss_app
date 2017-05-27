class Ability::Admin
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?
  end
end
