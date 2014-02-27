require 'spec_helper'

describe ListReview do
  
  context "associations" do
  	it { should belong_to(:list) }
  	it { should belong_to(:review) }
  end

  context "validations" do
  	it { should validate_presence_of(:list_id) }
  	it { should validate_presence_of(:review_id) }
  end

end
