require 'spec_helper'

describe Area do
  
  context "associations" do
  	it { should have_many(:neighborhoods) }
  	it { should belong_to(:city) }
  end

  context "validations" do
  	it { should validate_presence_of(:city_id) }
  	it { should validate_presence_of(:name) }
  end

end
