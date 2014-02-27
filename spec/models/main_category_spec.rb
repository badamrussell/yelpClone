require 'spec_helper'

describe MainCategory do
  
  context "validations" do
  	it { should validate_presence_of(:name) }
  end

end
