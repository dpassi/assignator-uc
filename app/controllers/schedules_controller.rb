require 'date'
class SchedulesController < ApplicationController
  before_action :authenticate_user!
  def new
  	@schedule = Schedule.new
  	@courses = Array.new
    current_user.courses.each do |course|
      @courses << [course.nrc.to_s + " - " +course.initials, course.nrc]
    end
    @modules = Array.new
    ["L","M","W","J","V","S"].each do |day|
    	8.times do |n|
    		@modules << day + (n+1).to_s
    	end
    end
    @modules = 1..8
  end

  def deleteAssignation
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

  def deleteAssignationDo
    assignation = Assignation.find params[:id]
    schedule = Schedule.find assignation.schedule_id
    puts assignation[:id]
    schedule.destroy
    assignation.destroy
    respond_to do |format|
      if assignation.destroyed? and schedule.destroyed?
        format.html { redirect_to schedules_deleteAssignation_path, :notice =>'Sala liberada con éxito'}
      else
        format.html { redirect_to schedules_deleteAssignation_path, :notice =>'Error al botar sala'}
      end
    end
  end

  def manual_do
    schedule = Schedule.find params[:id]
    salas = Classroom.all.sort_by {|h| -h[:capacity]}
    type = schedule.date.nil? ? "cursos" : "pruebas"
    curso = Course.find_by nrc: schedule[:nrc]
    dict = {:nrc=>curso[:nrc], :module => schedule[:module], :vacancy => curso[:vacancy], :date => schedule[:date], :schedule_id =>schedule[:id],:power_n => curso[:power_n],:projector => curso[:projector]}
    createAssignation type, dict, salas
    assign = Assignation.find_by schedule_id: schedule.id
    respond_to do |format|
      if assign.nil?
        format.html { redirect_to :asignaciones_manual, notice: 'Error al asignar sala' }
      else
        sala = Classroom.find assign.classroom_id
        format.html { redirect_to :asignaciones_manual, notice: 'Sala ' + sala.identifier + ' asignada correctamente al curso ' + curso.nrc.to_s + ' - ' + curso.initials }
      end
    end
  end




  def create
    @schedule = Schedule.new (params.require(:schedule).permit(:nrc, :date, :module))
    @schedule.tipo= "Otro"
    date_hash = eval @schedule.date
    date = Date.new(date_hash[1],date_hash[2],date_hash[3])
    day = date.strftime('%w').to_i
    if params[:semestral]
      @schedule.module = params[:day] + @schedule.module
      @schedule.date = nil
    else
      @schedule.module= ["D","L","M","w","J","V","S"][day] + @schedule.module
      @schedule.date = date.strftime('%F')
    end

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to :schedules_new, notice: 'Solicitud ingresada con éxito' }
      else
        format.html { redirect_to :schedules_new, notice: 'Solicitud ha fallado. Intente de nuevo' }
      end
    end
  end
end
