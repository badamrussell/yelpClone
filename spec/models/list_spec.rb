require 'spec_helper'

describe List do
  
  context "associations" do
  	it { should have_many(:list_reviews) }
  	it { should have_many(:reviews) }
  	it { should belong_to(:user) }
  end

  context "validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:user_id) }
  end

end
