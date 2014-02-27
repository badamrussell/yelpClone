require 'spec_helper'

describe Compliment do
	
  context "associations" do
  	it { should have_many(:review_compliments) }
  	it { should have_many(:reviews) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  end

end
