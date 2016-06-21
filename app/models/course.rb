class Course < ActiveRecord::Base
  belongs_to :users
  has_many :schedules
  validates_presence_of :initials, :section, :nrc, :vacancy#, :projector

  def to_s
    return nrc.to_s + " - " + initials
  end
end