class AssignationsController < ApplicationController
  before_action :authenticate_user!, :except  => [ :show ]
  def show
      @final_assignation = Array.new
      Assignation.all.each do |assignation|
      schedule = Schedule.find(assignation[:schedule_id])
      course = Course.find_by nrc: schedule[:nrc]
      classroom = Classroom.find(assignation[:classroom_id])
      dato = {:course => course, :schedule => schedule, :classroom =>classroom}
      @final_assignation << dato
      end
  end

  def select
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
  end

  def manual_select
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    @schedules = Array.new
    schedules = Schedule.all
    schedules.each do |schedule|
      if !(Assignation.find_by schedule_id: schedule.id)
        @schedules << schedule
      end
    end
  end

  def manual_do
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    schedule = Schedule.find params[:id]
    salas = Classroom.all.sort_by {|h| -h[:capacity]}
    type = schedule.date.nil? ? "cursos" : "pruebas"
    curso = Course.find_by nrc: schedule[:nrc]
    dict = {:nrc=>curso[:nrc], :module => schedule[:module], :vacancy => curso[:vacancy], :date => schedule[:date], :schedule_id =>schedule[:id],:power_n => curso[:power_n],:projector => curso[:projector]}
    assign = nil
    while salas.length > 0 and assign.nil?
      createAssignation type, dict, salas
      assign = Assignation.find_by schedule_id: schedule.id
    end
    respond_to do |format|
      if assign.nil?
        format.html { redirect_to :asignaciones_manual, notice: 'Error al asignar sala' }
      else
        sala = Classroom.find assign.classroom_id
        format.html { redirect_to :asignaciones_manual, notice: 'Sala ' + sala.identifier + ' asignada correctamente al curso ' + curso.nrc.to_s + ' - ' + curso.initials }
      end
    end
  end

  def generate
    raise "not authorized" unless AssignationPolicy.new(current_user, Assignation.new).create?
    #authorize @assignation, :create?

    horarios_cursos = Array.new
    horarios_pruebas = Array.new
    a =  Schedule.all
    a.each do |horario|
      if horario[:date] == nil
        curso = Course.find_by nrc:horario[:nrc]
        dict = {:nrc=>curso[:nrc], :module => horario[:module], :vacancy => curso[:vacancy], :date => horario[:date], :schedule_id =>horario[:id],:power_n => curso[:power_n],:projector => curso[:projector]}
        horarios_cursos << dict
      else
        curso = Course.find_by nrc:horario[:nrc]
        dict = {:nrc=>curso[:nrc], :module => horario[:module], :vacancy => curso[:vacancy], :date => horario[:date], :schedule_id =>horario[:id],:power_n => curso[:power_n],:projector => curso[:projector]}
        horarios_pruebas << dict
      end
    end
    horarios_cursos = horarios_cursos.sort_by {|h| -h[:vacancy]}
    horarios_pruebas= horarios_pruebas.sort_by {|h| -h[:vacancy]}
    salas = Classroom.all.sort_by {|h| -h[:capacity]}
    horarios_cursos.each do |dict|
      createAssignation "cursos", dict, salas
    end
    salas = Classroom.all.sort_by {|h| -h[:capacity]}
    horarios_pruebas.each do |dict|
      createAssignation "pruebas", dict, salas
    end
  end

  def createAssignation type, schedule, salas
    aux=false
    sala = salas.shift
    classroom_filter = Assignation.find_by classroom_id:sala[:id]
    if not classroom_filter
      puts 'La sala no está asignada y la podemos asignar'
      Assignation.create(:classroom_id => sala[:id], :schedule_id =>schedule[:schedule_id])
    else
      asignaciones = Assignation.where(:classroom_id=>sala[:id])
      asignaciones.each do |s_id|
        s = Schedule.find(s_id[:schedule_id])
        case type
          when "cursos"
            if s[:module] == schedule[:module]
              puts 'Sala ya está asignada'
              aux=true
              break
            end
          when "pruebas"
            if s[:module] == schedule[:module] && s[:date]== nil
              puts 'Sala esta ocupada todo el semestre'
              aux=true
              break
            elsif s[:module] == schedule[:module] && s[:date]==schedule[:date]
              puts 'Sala esta ocupada en esa fecha exacta'
              aux=true
              break
            end
          else
            nil
        end
      end
      if not aux
        puts 'Asignar Sala'
        Assignation.create(:classroom_id => sala[:id], :schedule_id =>schedule[:schedule_id])
      end
    end
  end
end

