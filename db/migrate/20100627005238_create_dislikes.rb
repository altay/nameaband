class CreateDislikes < ActiveRecord::Migration
  def self.up
    create_table :dislikes do |t|
      t.integer :name_id, :null=>false
      t.integer :user_id, :null=>false
      t.timestamps
    end
    add_index :dislikes, :name_id
    add_index :dislikes, :user_id

    add_column :names, :dislikes_count, :integer, :default=>0
    # name indexes for sorting
    add_index :names, :dislikes_count
  end

  def self.down
    remove_index :names, :column => :dislikes_count
    # name indexes for sorting
    remove_column :names, :dislikes_count

    remove_index :dislikes, :column => :user_id
    remove_index :dislikes, :column => :name_id
    drop_table :dislikes
  end
end
