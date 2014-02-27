require 'spec_helper'

describe ProfileLocation do
  
  context "associations" do
  	it { should belong_to(:user) }
  end

  context "validations" do
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:address) }
  end

end
