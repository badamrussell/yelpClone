require 'spec_helper'

describe FeatureValues do
  pending "add some examples to (or delete) #{__FILE__}"

  context "associations" do
  	it { should have_many(:features) }
  end

  context "validations" do
  	it { should validate_presence_of(:feature_id) }
  	it { should validate_presence_of(:name) }
  end

end
