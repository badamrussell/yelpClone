require 'spec_helper'

describe Tip do
	
  context "associations" do
  	it { should belong_to(:user) }
  	it { should belong_to(:business) }
  end

  context "validations" do
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:business_id) }
  	it { should validate_presence_of(:body) }
  end

end
