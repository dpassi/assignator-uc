require 'rails_helper'

RSpec.describe Assignation, type: :model do
  describe "create" do
  	let(:assignation){Assignation.new}
  	it "first" do
  		expect(assignation).not_to be_valid
  	end
  end
end
