class UsersController < ApplicationController
  before_action :authenticate_user!

  def myCourses
    @assignation_teacher = Array.new
    @courses = Array.new
    current_user.courses.each do |course|
      @courses << course.nrc.to_s
    end
    Assignation.all.each do |assignation|
      schedule = Schedule.find(assignation[:schedule_id])
      if @courses.include?(schedule[:nrc].to_s)
        classroom = Classroom.find(assignation[:classroom_id])
        course = Course.find_by nrc: schedule[:nrc]
        dato = {:course => course, :schedule => schedule, :classroom =>classroom, :assignation =>assignation}
        @assignation_teacher << dato
      end
    end
  end


  def index
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    @users = User.all
  end

  def rol
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    user = User.find(params[:id])
    if user.admin?
      user.user!
    else
      user.admin!
    end
    respond_to do |format|
        format.html { redirect_to users_index_path, :notice =>'Cambio realizado con éxito'}
    end
  end

  def assign
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    @user = User.find(params[:id])
    @courses = Array.new
    Course.all.each do |course|
      if course.user_id.nil?
        @courses << [course.nrc.to_s + " - " +course.initials, course.nrc]
      end
    end
  end

  def do_assign
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    @user = User.find(params[:id])
    @course = Course.find_by nrc: params[:user]["courses"]
    @course.user_id= @user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to users_assign_course_path, :notice =>'Curso ' + @course.to_s + ' asignado con exito'}
      else
        format.html { redirect_to users_assign_course_path, :notice =>'Error al asignar curso'}
      end
    end
  end


  def unassign
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    @user = User.find(params[:id])
    @courses = Array.new
    @user.courses.each do |course|
        @courses << [course.nrc.to_s + " - " +course.initials, course.nrc]
    end
  end

  def do_unassign
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    @user = User.find(params[:id])
    @course = Course.find_by nrc: params[:user]["courses"]
    if @user.id == @course.user_id
      @course.user_id= nil
    end
    respond_to do |format|
      if @course.save
        format.html { redirect_to users_unassign_course_path, :notice =>'Curso ' + @course.to_s + ' desasignado con exito'}
      else
        format.html { redirect_to users_unassign_course_path, :notice =>'Error al desasignar curso'}
      end
    end
  end
end
