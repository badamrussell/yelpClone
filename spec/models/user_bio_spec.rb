require 'spec_helper'

describe UserBio do
  
  context "associations" do
  	it { should belong_to(:user) }
  end

  context "validations" do
  	it { should validate_presence_of(:user_id) }
  	it { should validate_uniqueness_of(:user_id) }
  end

end
