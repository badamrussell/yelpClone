require 'spec_helper'

describe PhotoDetail do
  
  context "associations" do
		it { should belong_to(:photo) }
		it { should belong_to(:user) }
		it { should belong_to(:helpful) }
	end

	context "validations" do
		it { should validate_presence_of(:photo_id) }
		it { should validate_presence_of(:user_id) }
	end

  before(:each) do
    setup_factories
  end

  context "unique photo_id/user_id combination" do
    it "duplicate entry raises error" do

      user2 = create(:user, email: "b@b.com")
      business = Business.create(name: "terrible truckstop", country_id: 1)
      photo1 = Photo.create(business_id: business.id, user_id: User.first.id, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
      
      detail = PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: user2.id)
      detail2 = PhotoDetail.new(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: user2.id)
      
      expect { detail2.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User has already been taken")
    end
  end

  context "when added" do

  	pending "associated photo is updated" do
  		puts "not sure how to write the Mock for this"
  		photo1 = Photo.create(user_id: 1, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
  		activated = false
  		allow(photo1).to receive(:update_details) { puts "HEY"; activated = true }
  		PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: 2)

  		expect(activated).to be_true
  	end

  	it "associated photo#store_front_count is increased" do
  		business = Business.create(name: "terrible truckstop", country_id: 1)
  		photo1 = Photo.create(business_id: business.id, user_id: 1, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
  		# allow(photo1).to receive(:update)
  		detail = PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: 2)

  		expect(business.photos[0].store_front_count).to eq(1)
  	end
  end

  context "when removed" do

  	it "associated photo#store_front_count is is decreased" do
  		photo1 = Photo.create(user_id: 1, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
  		# allow(photo1).to receive(:update)
  		detail = PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: 2)
  		detail.destroy
  		expect(Photo.find(photo1.id).store_front_count).to eq(0)
  	end
  end

  context "associated business storefront" do

  	pending "is updated" do
  		business = Business.create(name: "terrible truckstop", country_id: 1)
  		photo1 = Photo.create(business_id: business.id, user_id: 1, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
  		photo2 = Photo.create(business_id: business.id, user_id: 1, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))

  		PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: 2)
  		expect(business.store_front_id).to eq(photo1.id)
  	end

  	it "business avatar changes" do
  		business = Business.create(name: "terrible truckstop", country_id: 1)
      user2 = create(:user, email: "b@b.com")
  		photo1 = Photo.create(business_id: business.id, user_id: User.first, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
  		photo2 = Photo.create(business_id: business.id, user_id: User.first, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))

  		PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: user2.id)
  		expect(business.store_front_id).to eq(photo1.id)
  	end

  	it "business avatar remains the same" do
  		business = Business.create(name: "terrible truckstop", country_id: 1)
      user2 = create(:user, email: "b@b.com")
  		photo1 = Photo.create(business_id: business.id, user_id: User.first.id, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))
  		photo2 = Photo.create(business_id: business.id, user_id: User.first.id, file: open("#{Rails.root.join}/app/assets/images/default_user.jpg"))

  		PhotoDetail.create(photo_id: photo1.id, helpful_id: Helpful.first.id, store_front: true, user_id: user2.id)
      business.reload
  		# PhotoDetail.create(photo_id: photo2.id, helpful_id: Helpful.first.id, store_front: true, user_id: user2.id)
  		expect(business.reload.store_front_id).to eq(photo1.id)
  	end
  end
end
