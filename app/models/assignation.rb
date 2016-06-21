class Assignation < ActiveRecord::Base
	has_one :schedule
	validates_presence_of :schedule_id, :classroom_id
end