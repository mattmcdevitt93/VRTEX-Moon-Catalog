class CreateUniverses < ActiveRecord::Migration
  def change
    create_table :universes do |t|
      t.integer :region_id
      t.string :region_name

      t.integer :constellation_id
      t.string :constellation_name
      
      t.integer :system_id
      t.string :system_name

      t.timestamps null: false
    end
  end
end
