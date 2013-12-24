class AlterStoreFrontDefault < ActiveRecord::Migration
  def change
    change_column_default(:photo_details, :store_front, false)
  end
end
