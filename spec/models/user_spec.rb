require 'spec_helper'

describe User do
  
  context "associations" do
  	it { should have_one(:bio) }
  	it { should have_many(:reviews) }
  	it { should have_many(:profile_locations) }
  	it { should have_many(:photos) }
  	it { should have_many(:photo_details) }
  	it { should have_many(:tips) }
  	it { should have_many(:review_votes) }
  	it { should have_many(:votes) }
  	it { should have_many(:compliments) }
  	it { should have_many(:review_compliments) }
  	it { should have_many(:lists) }
  	it { should have_many(:follows) }
  	it { should have_many(:fans) }
  	it { should have_many(:followees) }
  	it { should have_many(:leaders) }
  	it { should have_many(:bookmarks) }
  	it { should have_many(:bookmarked_businesses) }
  end

  context "validations" do
  	it { should validate_presence_of(:email) }
  	it { should validate_presence_of(:first_name) }
  	it { should validate_presence_of(:last_name) }
  	it { should validate_presence_of(:password_digest).with_message("Password cannot be blank.") }
  	it { should ensure_length_of(:password).is_at_least(6).on(:create) }
  end

  pending "#ensure_token" do
    
  end

  context "creation" do
  	it "prevents duplicate emails" do
      User.create(first_name: "b", last_name: "c", email: "b@c.com", password: "123456" )
      
      user2 = User.new(first_name: "a", last_name: "d", email: "b@c.com", password: "1234567" )
      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")
  	end
  end

  context "#verify_credentials" do
  	it "successful with correct credentials" do
      user1 = User.create(first_name: "b", last_name: "c", email: "b@c.com", password: "123456" )

      expect(User.verify_credentials("b@c.com","123456")).to eq(user1)
  	end

  	it "unsuccessful with wrong credentials" do
      user1 = User.create(first_name: "b", last_name: "c", email: "b@c.com", password: "123456" )

      expect(User.verify_credentials("b@c.com","1234567")).to be_nil
  	end
  end

  context "#name" do
  	it "returns full name" do
      user1 = User.create(first_name: "ben", last_name: "cupcake", email: "b@c.com", password: "123456" )

      expect(user1.name).to eq("ben c.")
  	end
  end

  context "#avatar" do
    it "has default photo" do
      user1 = User.create(first_name: "ben", last_name: "cupcake", email: "b@c.com", password: "123456" )

      expect(user1.avatar).to eq("/assets/default_user.jpg")
    end

    it "has uploaded photo" do
      user1 = create(:user, :profile_photo)

      expect(user1.avatar).to_not eq("/assets/default_user.jpg")
    end
  end

  context "PHOTOS" do
  	it "returns best photos" do
      user1 = create(:user)
      helpful = create(:helpful, name: "great", value: 1)
      photo1 = create(:photo, user: user1) 
      photo2 = create(:photo, user: user1) 

      detail = PhotoDetail.create(photo_id: photo1.id, helpful_id: helpful.id, user_id: User.first.id)
      
      expect(user1.top_photos(2)).to eq([photo1, photo2])
  	end
  end

  context "VOTES" do

    before(:each) do
      setup_factories
    end

  	it "#voted? on review" do
      user = User.first
      business = Business.create(name: "terrible truckstop", country_id: 1)
      review = create(:review, rating: 1, body: "awful", business_id: business.id)
      create(:review_vote, review_id: review.id, user_id: user.id )

      expect(user.voted?(review, 1)).to be_true
  	end

    context "#get_vote" do
    	it "returns valid vote" do
        user = User.first
        business = Business.create(name: "terrible truckstop", country_id: 1)
        review = create(:review, rating: 1, body: "awful", business_id: business.id)
        review_vote = create(:review_vote, review_id: review.id, user_id: user.id )

        expect(user.get_vote(review, 1)).to eq(review_vote.id)
    	end

      it "returns nil for no match" do
        user = User.first
        business = Business.create(name: "terrible truckstop", country_id: 1)
        review = create(:review, rating: 1, body: "awful", business_id: business.id)
        review_vote = create(:review_vote, review_id: review.id, user_id: user.id )

        expect(user.get_vote(review, 2)).to be_nil
      end
    end

  end

  context "COMPLIMENTS" do
    before(:each) do
      setup_factories
    end

  	it "#compliment_count" do
      user = create(:user)
      compliment1 = Compliment.create(name: "smart")
      compliment2 = Compliment.create(name: "cool")
      business = Business.create(name: "terrible truckstop", country_id: 1)
      review = create(:review, rating: 1, body: "awful", business_id: business.id, user: user)
      review2 = create(:review, rating: 1, body: "awful", business_id: business.id, user: user)
      create(:review_compliment, review_id: review.id, compliment_id: compliment1.id, user: User.first)
      create(:review_compliment, review_id: review2.id, compliment_id: compliment2.id, user: User.first)
      create(:review_compliment, review_id: review.id, compliment_id: compliment2.id, user: User.first)

      compliment_count = user.compliment_count

      if compliment_count[0]["id"] == compliment1.id
        expect(compliment_count[0]["count"]).to eq("1")
        expect(compliment_count[1]["count"]).to eq("2")
      else
        expect(compliment_count[0]["count"]).to eq("2")
        expect(compliment_count[1]["count"]).to eq("1")
      end
      
  	end
  end

  context "statistics" do
    before(:each) do
      setup_factories
    end
    
  	it "#vote_tallies" do
      user = create(:user)
      vote1 = create(:vote, name: "a")
      vote2 = create(:vote, name: "b")
      vote3 = create(:vote, name: "c")
      compliment1 = Compliment.create!(name: "smart")
      compliment2 = Compliment.create!(name: "cool")
      business = Business.create!(name: "terrible truckstop", country_id: 1)
      review = create(:review, rating: 1, body: "awful", business: business, user: user)
      review2 = create(:review, rating: 1, body: "awful", business: business, user: user)
      create(:review_compliment, review_id: review.id, compliment_id: compliment1.id, user: User.first)
      create(:review_compliment, review_id: review2.id, compliment_id: compliment2.id, user: User.first)
      create(:review_compliment, review_id: review.id, compliment_id: compliment2.id, user: User.first)
      create(:review_vote, review_id: review.id, user_id: 1, vote_id: vote1.id )
      create(:review_vote, review_id: review.id, user_id: 1 , vote_id: vote2.id)
      create(:review_vote, review_id: review2.id, user_id: 1 , vote_id: vote3.id)
      create(:review_vote, review_id: review2.id, user_id: 1, vote_id: vote2.id)
      
      tallies = user.reload.vote_tallies

      expect(tallies[vote1.name]).to eq(1)
      expect(tallies[vote2.name]).to eq(2)
      expect(tallies[vote3.name]).to eq(1)
      expect(tallies["compliments"]).to eq(3)

  	end
  end

end
