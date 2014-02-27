require 'spec_helper'

describe Neighborhood do

  context "associations" do
  	it { should have_many(:businesses) }
  	it { should belong_to(:area) }
  end

  context "validations" do
  	it { should validate_presence_of(:area_id) }
  	it { should validate_presence_of(:name) }
  end

end
