class Classroom < ActiveRecord::Base
  belongs_to :assignations
  validates_presence_of :identifier, :name, :capacity, :power_n#, :projector
end

