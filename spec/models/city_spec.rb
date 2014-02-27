require 'spec_helper'

describe City do
	
  context "associations" do
  	it { should have_many(:areas) }
  	it { should have_many(:neighborhoods) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  end

end
