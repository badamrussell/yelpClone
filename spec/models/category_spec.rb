require 'spec_helper'

describe Category do
  before { setup_db }

  context "associations" do
  	it { should belong_to(:main_category) }
  end

  context "validations" do
  	it { should validate_presence_of(:main_category_id) }
  	it { should validate_presence_of(:name) }
  end


  context "related businesses in a category" do
  	let(:category) { create(:category, name: "a") }

  	it "by best businesses" do
	  	business1 = create(:business, category_ids: [category.id])
	  	business2 = create(:business, category_ids: [category.id])
	  	business3 = create(:business, category_ids: [category.id])

  		create(:review, rating: 5, body: "awful", business_id: business2.id)
  		create(:review, rating: 4, body: "awful", business_id: business1.id)
  		create(:review, rating: 1, body: "awful", business_id: business3.id)

  		expect(Category.best_businesses(3, [category.id])).to eq([business2, business1, business3])
  	end

  	it "by new businesses" do
	  	business1 = create(:business, category_ids: [category.id])
	  	business2 = create(:business, category_ids: [category.id])
	  	business3 = create(:business, category_ids: [category.id])
  		expect(category.new_businesses(3).pluck(:id)).to eq([business3.id, business2.id, business1.id])
  	end

  end

  context "related photos in a category" do
  	let(:category) { create(:category, name: "a") }
  	let(:business1) { create(:business, category_ids: [category.id]) }

  	it "by most recent" do
  		photo1 = create(:photo, business_id: business1.id)
  		photo2 = create(:photo, business_id: business1.id)
  		photo3 = create(:photo, business_id: business1.id)

  		expect(category.new_photos(3).pluck(:id)).to eq([photo3.id, photo2.id, photo1.id])
  	end

  end

  context "related reviews in a category" do
  	let(:category) { create(:category, name: "a") }
  	let(:business1) { create(:business, category_ids: [category.id]) }
  	let(:business2) { create(:business, category_ids: [category.id]) }

  	it "by most recent" do
  		review1 = create(:review, rating: 1, body: "awful", business_id: business1.id)
  		review2 = create(:review, rating: 1, body: "awful", business_id: business2.id)
  		review3 = create(:review, rating: 1, body: "awful", business_id: business1.id)

  		expect(category.new_reviews(3).pluck(:id)).to eq([review3.id, review2.id, review1.id])
  	end
  end
end
