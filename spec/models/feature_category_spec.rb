require 'spec_helper'

describe FeatureCategory do
  
  context "associations" do
  	it { should have_many(:features) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:input_type) }
  end

end
