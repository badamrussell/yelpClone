class AppendDescToList < ActiveRecord::Migration
  def change
    add_column :lists, :desc, :string
  end
end
