class CreateGoodForMeals < ActiveRecord::Migration
  def change
    create_table :good_for_meals do |t|

      t.timestamps
    end
  end
end
