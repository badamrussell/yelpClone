class CreateAmbiences < ActiveRecord::Migration
  def change
    create_table :ambiences do |t|

      t.timestamps
    end
  end
end
