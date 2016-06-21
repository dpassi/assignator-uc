require 'rspec'
require 'spec_helper'

RSpec.describe Schedule, :type => :model do
  it "is valid with valid nrc" do
    expect(Schedule.new(:nrc => nil)).not_to be_valid
  end
  it "is not valid without a module" do
    schedule = Schedule.new(:module => nil)
    expect(schedule).to_not be_valid
  end
  it "is not valid without a tipo" do
    schedule = Schedule.new(:tipo => nil )
    expect(schedule).to_not be_valid
  end
end

RSpec.describe Course, :type => :model do
  it "is valid with valid nrc" do
    expect(Course.new(:nrc => nil)).not_to be_valid
  end
  it "is valid with valid initials" do
    expect(Course.new(:initials => nil)).not_to be_valid
  end
  it "is valid with valid section" do
    expect(Course.new(:section => nil)).not_to be_valid
  end
  it "is valid with valid vacancy" do
    expect(Course.new(:vacancy => nil)).not_to be_valid
  end
  it "is valid with valid projector" do
    expect(Course.new(:projector => nil)).not_to be_valid
  end
  it "is valid with valid power_n" do
    expect(Course.new(:power_n => nil)).not_to be_valid
  end
end

RSpec.describe Classroom, :type => :model do
  it "is valid with valid identifier" do
    expect(Classroom.new(:identifier => nil)).not_to be_valid
  end
  it "is valid with valid name" do
    expect(Classroom.new(:name => nil)).not_to be_valid
  end
  it "is valid with valid capacity" do
    expect(Classroom.new(:capacity => nil))
  end
  it "is valid with valid power_n" do
    expect(Classroom.new(:power_n => nil))
  end
  it "is valid with valid projector" do
    expect(Classroom.new(:projector => nil))
  end
end


RSpec.describe Assignation, :type => :model do
  it "is valid with valid schedule_id" do
    expect(Assignation.new(:schedule_id => nil)).not_to be_valid
  end
  it "is not valid without a classroom_id" do
    schedule = Assignation.new(:classroom_id => nil)
    expect(schedule).to_not be_valid
  end
end

