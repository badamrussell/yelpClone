class AppendValueHelpful < ActiveRecord::Migration
  def change
  	add_column :helpfuls, :value, :integer, default: 0
  end
end
