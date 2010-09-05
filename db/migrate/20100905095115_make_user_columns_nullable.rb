class MakeUserColumnsNullable < ActiveRecord::Migration
  def self.up
    create_table :users_temp do |t|
     t.string    :login
     t.string    :email
     t.string    :crypted_password
     t.string    :password_salt
     t.string    :persistence_token
     t.string    :single_access_token
     t.string    :perishable_token
     t.string    :fb_name
     t.integer   :facebook_uid, :limit => 8

     # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
     t.integer   :login_count,         :default => 0 
     t.integer   :failed_login_count,  :default => 0 
     t.datetime  :last_request_at                                    
     t.datetime  :current_login_at                                 
     t.datetime  :last_login_at                                     
     t.string    :current_login_ip                                   
     t.string    :last_login_ip                                      

     t.timestamps
    end
    execute("INSERT INTO users_temp SELECT * FROM users")
    rename_table :users, :users_old
    rename_table :users_temp, :users
  end

  def self.down
  end
end
