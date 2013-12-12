class CreateAmbienceReviews < ActiveRecord::Migration
  def change
    create_table :ambience_reviews do |t|

      t.timestamps
    end
  end
end
