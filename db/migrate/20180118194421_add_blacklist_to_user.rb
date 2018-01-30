class AddBlacklistToUser < ActiveRecord::Migration
  def change
    add_column :users, :blacklist, :boolean, default: false
  end
end
