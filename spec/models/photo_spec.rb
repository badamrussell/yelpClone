require 'spec_helper'

describe Photo do
  
  context "associations" do
 		it { should belong_to(:user) }
 		it { should belong_to(:business) }
 		it { should belong_to(:review) }
 		it { should have_many(:photo_details) }
 	end

 	context "validations" do
 		it { should validate_presence_of(:user_id) }
 	end

  before(:each) do
    setup_factories
  end

  context "for businesses" do
  	
  	it "updates the business avatar" do
  		business = create(:business)
  		photo1 = create(:photo, business_id: business.id) 
  		expect(photo1.url).to eq(business.reload.avatar)

  		# WAY TO USE THE EXPECT/CHANGE SYNTAX?
  		# expect { create(:photo, business_id: business.id) }.to change { business.reload.avatar }.to be(1)
  	end

  	it "has the most-voted photo as avatar" do
  		business = create(:business)

  		photo1 = create(:photo, business_id: business.id, store_front_count: 0, user: User.first)
  		photo2 = create(:photo, business_id: business.id, store_front_count: 3, user: User.first)
  		photo3 = create(:photo, business_id: business.id, store_front_count: 2, user: User.first)

  		expect(photo2.id).to eq(business.reload.store_front_id)
  	end
  end

end
