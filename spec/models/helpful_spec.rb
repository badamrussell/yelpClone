require 'spec_helper'

describe Helpful do
  
  context "validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:value) }
  end

end
