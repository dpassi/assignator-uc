class CoursePolicy
	attr_reader :user, :course

  def initialize(user, course)
    @user = user
    @course = course
  end

  def create?
    user.admin?
  end
end