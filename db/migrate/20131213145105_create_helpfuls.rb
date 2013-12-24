class CreateHelpfuls < ActiveRecord::Migration
  def change
    create_table :helpfuls do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
