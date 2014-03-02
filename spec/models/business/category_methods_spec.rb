require 'spec_helper'

describe Business, "::CategoryMethods" do
  
  context "associations" do
    it { should belong_to(:category1) }
    it { should belong_to(:category2) }
    it { should belong_to(:category3) }
  end

  before(:each) do
    setup_factories
  end

  # subject(:business) { create(:business) }

  context "#categories" do
  	it "have the correct categories" do
      c1 = create(:category, name: "a", main_category: MainCategory.first)
      c2 = create(:category, name: "b", main_category: MainCategory.first)
      c3 = create(:category, name: "c", main_category: MainCategory.first)
      business1 = Business.create(name: "Terrible Restaurant", country_id: 1, category_ids: [c1.id,c2.id,c3.id])

      expect(business1.categories.pluck(:id)).to eq([c1.id,c2.id,c3.id]) 
  	end
  end

end
