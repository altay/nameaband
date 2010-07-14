class AddFbFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_name, :string
    add_column :users, :facebook_uid, :integer, :limit => 8
  end

  def self.down
    remove_column :users, :facebook_uid
    remove_column :users, :fb_name
  end
end
