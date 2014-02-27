require 'spec_helper'

describe Country do
	
  context "associations" do
  	it { should have_many(:businesses) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  end

end
