class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.integer :user_id
      t.integer :entry_id

      t.integer :system_id
      t.string :system_esi

      t.integer :planet_id
      t.string :planet_esi

      t.integer :moon_id
      t.string :moon_esi

      t.integer :product_id
      t.string :product
      t.decimal :percent, :precision => 8, :scale => 8
      
      t.integer :status
      t.boolean :verified
      t.integer :flag

      t.timestamps null: false
    end
  end
end
