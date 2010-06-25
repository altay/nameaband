class AddUserIdToNames < ActiveRecord::Migration
  def self.up
    add_column :names, :user_id, :integer
    add_index :names, :user_id
  end

  def self.down
    remove_index :names, :column => :user_id
    remove_column :names, :user_id
  end
end
