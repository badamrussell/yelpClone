require 'spec_helper'

describe Business,"::LocationMethods" do
  
  context "associations" do
    it { should belong_to(:country) }
    it { should belong_to(:neighborhood) }
  end

  # context "validations" do
    
  # end

  # before(:each) do
  #   setup_factories
  # end

  # subject(:business) { create(:business) }

  pending "location" do
    
  end

end
