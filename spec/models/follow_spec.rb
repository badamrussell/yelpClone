require 'spec_helper'

describe Follow do
  
  context "associations" do
  	it { should belong_to(:fan) }
  	it { should belong_to(:leader) }
  end

  context "validations" do
  	it { should validate_presence_of(:fan_id) }
  	it { should validate_presence_of(:leader_id) }
  end

end
