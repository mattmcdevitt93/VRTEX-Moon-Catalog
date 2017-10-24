class CreateMoons < ActiveRecord::Migration
  def change
    create_table :moons do |t|
      t.integer :entry_id
      t.string :product
      t.decimal :quantity, :precision => 8, :scale => 8
      t.integer :ore_type_id
      t.integer :system_id
      t.integer :planet_id
      t.integer :moon_id
      t.boolean :validation

      t.timestamps null: false
    end
  end
end
