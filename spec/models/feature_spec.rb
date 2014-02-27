require 'spec_helper'

describe Feature do
  
  context "associations" do
  	it { should have_many(:businesses) }
  	it { should have_many(:business_features) }
  	it { should belong_to(:category) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:feature_category_id) }
  end

end
