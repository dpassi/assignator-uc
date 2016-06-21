class SchedulePolicy
	attr_reader :user, :schedule

  def initialize(user, schedule)
    @user = user
    @schedule = schedule
  end

  def create?
    user.admin?
  end
end