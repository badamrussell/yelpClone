class CreatePriceRanges < ActiveRecord::Migration
  def change
    create_table :price_ranges do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
