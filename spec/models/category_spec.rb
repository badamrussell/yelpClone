require 'spec_helper'

describe Category do
  
  context "associations" do
  	it { should belong_to(:main_category) }
  end

  context "validations" do
  	it { should validate_presence_of(:main_category_id) }
  	it { should validate_presence_of(:name) }
  end

  before(:each) do
    setup_factories
  end

  context "related businesses in a category" do

  	it "by best businesses" do
      category = create(:category, name: "a", main_category: MainCategory.first)
	  	business1 = create(:business, category_ids: [category.id])
	  	business2 = create(:business, category_ids: [category.id])
	  	business3 = create(:business, category_ids: [category.id])

      user = User.first
  		create(:review, rating: 5, body: "awful", business: business2, user: user)
  		create(:review, rating: 4, body: "awful", business: business1, user: user)
  		create(:review, rating: 1, body: "awful", business: business3, user: user)

  		expect(Category.best_businesses(3, [category.id])).to eq([business2, business1, business3])
  	end

  	it "by new businesses" do
      category = create(:category, name: "a", main_category: MainCategory.first)
	  	business1 = create(:business, category_ids: [category.id])
	  	business2 = create(:business, category_ids: [category.id])
	  	business3 = create(:business, category_ids: [category.id])
  		expect(category.new_businesses(3).pluck(:id)).to eq([business3.id, business2.id, business1.id])
  	end

  end

  context "related photos in a category" do

  	it "by most recent" do
      category = create(:category, name: "a", main_category: MainCategory.first)
      business1 = create(:business, category_ids: [category.id])
      user = User.first
  		photo1 = create(:photo, business: business1, user: user)
  		photo2 = create(:photo, business: business1, user: user)
  		photo3 = create(:photo, business: business1, user: user)

  		expect(category.new_photos(3).pluck(:id)).to eq([photo3.id, photo2.id, photo1.id])
  	end

  end

  context "related reviews in a category" do
  	
    it "by most recent" do
      category = create(:category, name: "a", main_category: MainCategory.first)
      business1 = create(:business, category_ids: [category.id])
      business2 = create(:business, category_ids: [category.id]) 

      user = User.first
  		review1 = create(:review, rating: 1, body: "awful", business: business1, user: user)
  		review2 = create(:review, rating: 1, body: "awful", business: business2, user: user)
  		review3 = create(:review, rating: 1, body: "awful", business: business1, user: user)

  		expect(category.new_reviews(3).pluck(:id)).to eq([review3.id, review2.id, review1.id])
  	end
  end
end
