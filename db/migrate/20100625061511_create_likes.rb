class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :name_id, :null=>false
      t.integer :user_id, :null=>false
      t.timestamps
    end
    add_index :likes, :name_id
    add_index :likes, :user_id

    add_column :names, :likes_count, :integer, :default=>0
    # name indexes for sorting
    add_index :names, :likes_count
    add_index :names, :name
    add_index :names, :created_at
  end

  def self.down
    remove_index :names, :column => :created_at
    remove_index :names, :column => :name
    remove_index :names, :column => :likes_count
    # name indexes for sorting
    remove_column :names, :likes_count

    remove_index :likes, :column => :user_id
    remove_index :likes, :column => :name_id
    drop_table :likes
  end
end
