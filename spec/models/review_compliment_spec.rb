require 'spec_helper'

describe ReviewCompliment do
  
  context "associations" do
  	it { should belong_to(:review) }
  	it { should belong_to(:user) }
  	it { should belong_to(:compliment) }
  end

  context "validations" do
  	it { should validate_presence_of(:review_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:compliment_id) }
  end

end
