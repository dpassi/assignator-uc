class AssignationPolicy
	attr_reader :user, :assignation

  def initialize(user, assignation)
    @user = user
    @assignation = assignation
  end

  def create?
    user.admin?
  end
end