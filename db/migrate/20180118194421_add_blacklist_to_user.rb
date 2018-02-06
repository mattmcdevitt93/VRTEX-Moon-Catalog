class AddBlacklistToUser < ActiveRecord::Migration
  def change
    add_column :users, :blacklist, :boolean, default: false
    add_column :users, :approved_user, :boolean, default: false
    add_column :users, :flags, :integer, default: 0
  end
end
