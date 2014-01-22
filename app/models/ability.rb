class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new # guest user (not logged in)
   if user.email == 'nina.moskalyk@gmail.com'
     can :manage, :all
   else
     can :manage, Report
   end
  end
end
