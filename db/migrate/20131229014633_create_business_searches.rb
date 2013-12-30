class CreateBusinessSearches < ActiveRecord::Migration
  def change
    create_table :business_searches do |t|
      t.integer :business_id, null: false
      t.tsvector :words

      t.timestamps
    end

    add_index :business_searches, :business_id

    execute <<-SQL
      CREATE INDEX word_search_idx
      ON business_searches
      USING gin(words);
    SQL


  end
end
