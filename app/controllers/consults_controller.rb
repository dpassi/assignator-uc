class ConsultsController < ApplicationController
  def index
    @courses = Array.new
    @classrooms = Array.new
    Course.all.each do |course|
      @courses << course[:initials] if not @courses.include?(course[:initials])
      Class
    end
    Classroom.all.each do |classroom|
      @classrooms << classroom[:identifier] if not @classrooms.include?(classroom[:identifier])
    end
    @courses_info = Array.new
    Classroom.all.each do |a|
      @courses_info << [a[:name],a[:id]]
    end
  end

  def classroomByCourseOrSchedule # consultar sala de un curso y horario
    @course = request.GET[:course]
    resultado = Array.new
    Assignation.all.each do |assignation|
      schedule = Schedule.find(assignation[:schedule_id])
      course = Course.find_by nrc: schedule[:nrc]
      if course[:initials] == @course
        @nombre_curso= course[:initials]
        dict_elem = {:classroom =>Classroom.find(assignation[:classroom_id]), :course => course, :schedule =>schedule}
        resultado << dict_elem
      end

    end
    cursos_dict = {}
    resultado.each do |k|
      elemento=k[:course][:nrc].to_s.to_sym
      if not cursos_dict.key?(elemento)
        cursos_dict[elemento]=Array.new
      else
        cursos_dict[elemento] << {:course =>k[:course], :classroom => k[:classroom],:schedule =>k[:schedule]}
      end
    end
    @result=cursos_dict
    puts @result
  end

  def courseByClassroomAndSchedule # consultar sala de un curso y horario
    @classroom = request.GET[:classroom]
    @schedule_module = request.GET[:day]+request.GET[:module]
    @curso_consulta2 = nil
    Assignation.all.each do |assignation|
      schedule = Schedule.find(assignation[:schedule_id])
      classroom = Classroom.find(assignation[:classroom_id])
      if classroom[:identifier] == @classroom && @schedule_module == schedule[:module]
        course = Course.find_by(:nrc => schedule[:nrc])
        @curso_consulta2 = course[:initials].to_s
        break
      end
    end
    if @curso_consulta2 == nil
      @curso_consulta2 = 'No se encontró un curso para esa Sala y Horario Especifico'
    end
  end



  def consult2
    sala='J4'
    horario='V1'
    final_assignation = Array.new
    Assignation.all.each do |assignation|
      schedule = Schedule.find(assignation[:schedule_id])
      course = Course.find_by nrc: schedule[:nrc]
      classroom = Classroom.find(assignation[:classroom_id])
      dato = {:course => course, :schedule => schedule, :classroom =>classroom}
      final_assignation << dato
      dato = final_assignation.select{|result| result[:schedule][:module]==horario && result[:classroom][:name]==sala}
      puts dato

    end

  end

  def show_information
    @sala = Classroom.find(params[:course])
    puts @sala[:latitude]
  end

end
