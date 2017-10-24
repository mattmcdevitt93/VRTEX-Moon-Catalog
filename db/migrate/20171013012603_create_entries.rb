class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :content
      t.string :user
      t.boolean :format_check, default: false

      t.timestamps null: false
    end
  end
end
