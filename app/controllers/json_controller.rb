require "rubygems"
require "json"
require "net/http"
require "uri"


class JsonController < ApplicationController
  before_action :authenticate_user!
  def databaseLoad
    downloadClassrooms
    downloadCourses
    downloadSchedules
  end

  def chooseDate(imodule,month)
    if imodule == 'L'
      day = 1
    elsif imodule == 'M'
      day = 2
    elsif imodule == 'W'
      day = 3
    elsif imodule == "J"
      day = 4
    else
      day = 5
    end

    if month == 4
      start_date = Date.parse('2016-04-01') # your start
      end_date = Date.parse('2016-04-30') # your end
      my_days = [day] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
      result = (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
      return result.sample
    elsif month == 5
      start_date = Date.parse('2016-05-01') # your start
      end_date = Date.parse('2016-05-31') # your end
      my_days = [day] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
      result = (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
      return result.sample
    elsif month == 6
      start_date = Date.parse('2016-06-01') # your start
      end_date = Date.parse('2016-06-30') # your end
      my_days = [day] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
      result = (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
      return result.sample
    else
      start_date = Date.parse('2016-07-01') # your start
      end_date = Date.parse('2016-07-31') # your end
      my_days = [day] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
      result = (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
      return result.sample
    end
  end

  def downloadSchedules
    authorize Schedule.new, :create?
    require 'time'
    uri = URI.parse("http://uc-courses.lopezjuri.com/api/v1/courses?initials=MAT")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    if response.code == "200"
      result = JSON.parse(response.body)
      result.each do |doc|
        schedule = doc['schedule']
        schedule.each do |s|
          if s['identifier'] == 'CAT'
            days = ['L','M','W','J','V']
            i1module = days.sample
            i2module = days.sample
            i3module = days.sample
            exammodule = days.sample
            Schedule.create!(:nrc => doc['NRC'], :module => i1module+'7', :date => Date.parse(chooseDate(i1module,4).to_s) , :tipo =>"I1")
            Schedule.create!(:nrc => doc['NRC'], :module => i2module+'7', :date => Date.parse(chooseDate(i2module,5).to_s) , :tipo =>'I2')
            Schedule.create!(:nrc => doc['NRC'], :module => i3module+'7', :date => Date.parse(chooseDate(i3module,6).to_s), :tipo =>'I3')
            Schedule.create!(:nrc => doc['NRC'], :module => exammodule+'7', :date => Date.parse(chooseDate(exammodule,7).to_s) , :tipo =>'EXAM')
            s['modules'].each do |i|
              i['hours'].each do |h|
                Schedule.create!(:nrc => doc['NRC'], :module => i['day']+h.to_s, :date => nil , :tipo =>'Cat')
              end
            end
          elsif s['identifier'] == 'AYUD'
            s['modules'].each do |i|
              i['hours'].each do |h|
                Schedule.create!(:nrc => doc['NRC'], :module => i['day']+h.to_s, :date => nil, :tipo =>'Ayud')
              end
            end

          end
        end
      end
    else
      puts "Error"
    end
  end
  def downloadClassrooms
    authorize Classroom.new, :create?
    uri = URI.parse("http://uc-maps.lopezjuri.com/api/v1/places")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code == "200"
      result = JSON.parse(response.body)
      result.each do |doc|
        if doc['categories'][0] == 'classroom'
          puts 'CLASSROOM'
          name = doc['name']
          identifier = doc['identifier']
          information = doc['information']
          floor = doc['location']['floor']
          prng = Random.new(seed = Random.new_seed)
          vaccancy = prng.rand(20..100)
          prng = Random.new(seed = Random.new_seed)
          power_n = prng.rand(5..10)
          prng = Random.new(seed = Random.new_seed)
          coordinates = doc['location']['coordinates']
          aux =  prng.rand(0..1)
          if aux == 0
            projector = false
          else
            projector = true
          end
          Classroom.create!(:identifier => identifier, :name => name, :information => information, :floor =>1, :capacity =>vaccancy, :power_n => power_n, :projector => projector, :latitude =>coordinates[1], :longitude => coordinates[0])
        end
      end
    else
      puts "ERROR!!!"
    end
  end

  def downloadCourses
    authorize Course.new, :create?
    uri = URI.parse("http://uc-courses.lopezjuri.com/api/v1/courses?initials=MAT")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code == "200"
      result = JSON.parse(response.body)
      result.each do |doc|
        nrc = doc['NRC']
        initials = doc['initials']
        section = doc['section']
        name = doc['name']
        information = doc['information']
        prng = Random.new(seed = Random.new_seed)
        vaccancy = prng.rand(20..100)
        prng = Random.new(seed = Random.new_seed)
        power_n = prng.rand(0..7)
        prng = Random.new(seed = Random.new_seed)
        aux =  prng.rand(0..1)
        if aux == 0
          projector = false
        else
          projector = true
        end
        puts [initials, section, nrc, information, vaccancy, power_n, projector]
        Course.create!(:initials =>initials, :section =>section, :nrc =>nrc, :information =>information, :vacancy =>vaccancy, :power_n => power_n, :projector => projector)
      end
    else
      puts "Error"
    end
  end

end

