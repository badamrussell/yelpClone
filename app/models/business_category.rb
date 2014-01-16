class BusinessCategory < ActiveRecord::Base
  attr_accessible :business_id, :category_id

  validates :category_id, presence: true
  validates :business_id, uniqueness: { scope: :category_id }
  validates :business_id, :category_id, numericality: true, allow_nil: true

  validate :business_existence

  belongs_to(
    :business,
    class_name: "Business",
    primary_key: :id,
    foreign_key: :business_id
  )

  belongs_to(
    :category,
    class_name: "Category",
    primary_key: :id,
    foreign_key: :category_id
  )

  private

    def business_existence
      if business.nil? && business_id.nil?
        errors.add(:base, "No business associated to Category")
      end
    end

end
