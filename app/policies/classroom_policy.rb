class ClassroomPolicy
	attr_reader :user, :classroom

  def initialize(user, classroom)
    @user = user
    @classroom = classroom
  end

  def create?
    user.admin?
  end
end