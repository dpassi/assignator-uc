class StatisticsController < ApplicationController
  def show
     frecuencia_de_cursos
     frecuencia_de_pruebas
     exito_algoritmo
  end

  def exito_algoritmo
    @final_assignation = Array.new
    Assignation.all.each do |assignation|
      schedule = Schedule.find(assignation[:schedule_id])
      course = Course.find_by nrc: schedule[:nrc]
      classroom = Classroom.find(assignation[:classroom_id])
      dato = {:course => course, :schedule => schedule, :classroom =>classroom}
      @final_assignation << dato
    end
    @cantidad_falla=0
    @cantidad_bien=0
    @falla_proyector=0
    @falla_capacidad=0
    @falla_enchufes=0
    @cantidad_cursos_por_modulo= Hash.new

    @final_assignation.each do |a|
      if a[:schedule][:tipo]=='Cat' or a[:schedule][:tipo]=='Ayud'
        if not @cantidad_cursos_por_modulo.key?(a[:schedule][:module])
          @cantidad_cursos_por_modulo[a[:schedule][:module]]=1

        else
          @cantidad_cursos_por_modulo[a[:schedule][:module]]+=1
          if  a[:course][:vacancy]  > a[:classroom][:capacity]
            @falla_capacidad+=1
            @cantidad_falla+=1
          elsif a[:course][:power_n] > a[:classroom][:power_n]
            @falla_enchufes+=1
            @cantidad_falla+=1
          elsif a[:course][:projector] == true and a[:classroom][:projector] == false
            @falla_proyector+=1
            @cantidad_falla+=1
          else
            @cantidad_bien+=1
          end
        end
      end

    end
    @densidad_cursos=Hash.new
    cantidad_salas=Classroom.count
    @cantidad_cursos_por_modulo.keys.each do |llave|
      @densidad_cursos[llave]= @cantidad_cursos_por_modulo[llave].to_f*100/cantidad_salas.to_f
    end
  end

  def frecuencia_de_pruebas
    lp = 0
    mp = 0
    wp = 0
    jp = 0
    vp = 0
    sp = 0
    horarios = Schedule.all
    horarios.each do |h|
      if h[:tipo] == "I1" or h[:tipo] == "I2" or h[:tipo] == "I3" or h[:tipo] == "EXAM"
        if h[:module][0] == "L"
          lp+=1
        elsif h[:module][0] == "M"
          mp+=1
        elsif h[:module][0] == "W"
          wp+=1
        elsif h[:module][0] == "J"
          jp+=1
        elsif h[:module][0] == "V"
          vp+=1
        elsif h[:module][0] == "S"
          sp+=1
        end
      end
    end
    @frecuencia_diaria_pruebas = [["Lunes",lp],["Martes",mp],["Miercoles",wp],["Jueves",jp],["Viernes",vp],["Sabado",sp]]
  end


  def frecuencia_de_cursos
    lc = 0
    mc = 0
    wc = 0
    jc = 0
    vc = 0
    sc = 0
    la = 0
    ma = 0
    wa = 0
    ja = 0
    va = 0
    sa = 0
    horarios = Schedule.all
    horarios.each do |h|
      if h[:tipo] == "Cat"
        if h[:module][0] == "L"
          lc+=1
        elsif h[:module][0] == "M"
          mc+=1
        elsif h[:module][0] == "W"
          wc+=1
        elsif h[:module][0] == "J"
          jc+=1
        elsif h[:module][0] == "V"
          vc+=1
        elsif h[:module][0] == "S"
          sc+=1
        end
      elsif h[:tipo] == "Ayud"
        if h[:module][0] == "L"
          la+=1
        elsif h[:module][0] == "M"
          ma+=1
        elsif h[:module][0] == "W"
          wa+=1
        elsif h[:module][0] == "J"
          ja+=1
        elsif h[:module][0] == "V"
          va+=1
        elsif h[:module][0] == "S"
          sa+=1
        end
    end
    end
    @frecuencia_diaria_catedra = [["Lunes",lc],["Martes",mc],["Miercoles",wc],["Jueves",jc],["Viernes",vc],["Sabado",sc]]
    @frecuencia_diaria_ayudantia = [["Lunes",la],["Martes",ma],["Miercoles",wa],["Jueves",ja],["Viernes",va],["Sabado",sa]]
    end
end
