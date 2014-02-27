require 'spec_helper'

describe FeatureValue do
	
  context "associations" do
  	it { should belong_to(:features) }
  end

  context "validations" do
  	it { should validate_presence_of(:feature_id) }
  	it { should validate_presence_of(:name) }
  end

end
