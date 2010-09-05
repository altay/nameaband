class AddAnonymousToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :anonymous, :boolean, :default=>true
  end

  def self.down
    remove_column :users, :anonymous
  end
end
