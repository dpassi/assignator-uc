class ViewerController < ApplicationController
  def show_information
    @sala = Classroom.first
    puts @sala[:latitude]
  end
end

