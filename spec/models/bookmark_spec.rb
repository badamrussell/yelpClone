require 'spec_helper'

describe Bookmark do
  
  context "associations" do
  	it { should belong_to(:business) }
  	it { should belong_to(:user) }
  end

  context "validations" do
  	it { should validate_presence_of(:business_id) }
  	it { should validate_presence_of(:user_id) }
  end
  
end
