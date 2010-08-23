class CreateExistingBands < ActiveRecord::Migration
  def self.up
    create_table :existing_bands do |t|
      t.integer :user_id # the user who marked this band as existing
      t.integer :name_id # the name of the band
      t.string :url # this band's presence online

      t.timestamps
    end
    add_index :existing_bands, :user_id
    add_index :existing_bands, :name_id
  end

  def self.down
    remove_index :existing_bands, :column => :name_id
    remove_index :existing_bands, :column => :user_id
    drop_table :existing_bands
  end
end
