require 'spec_helper'

describe Business,"::PhotoMethods" do
  
  context "associations" do
  	it { should have_many(:photos) }
    it { should belong_to(:store_front_photo) }
    it { should have_many(:photo_details) }
  end

  before(:each) do
    setup_factories
  end

  subject(:business) { create(:business) }

  context "#avatar" do
    it "has default image" do
      expect(business.avatar).to eq("/assets/default_house.jpg")
    end
  end

  context "#store_fronts" do
    it "returns correct number of photos in order" do
      photo1 = create(:photo, business_id: business.id, store_front_count: 0, user: User.first)
      photo2 = create(:photo, business_id: business.id, store_front_count: 3, user: User.first)
      photo3 = create(:photo, business_id: business.id, store_front_count: 2, user: User.first)

      expect(business.store_fronts(3)).to eq([photo2, photo3, photo1])
    end
  end

end
