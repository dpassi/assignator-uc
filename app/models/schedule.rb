class Schedule < ActiveRecord::Base
  belongs_to :assignations
  belongs_to :courses
  validates_presence_of :nrc, :module, :tipo
end