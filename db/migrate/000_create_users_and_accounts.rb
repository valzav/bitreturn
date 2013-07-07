class CreateUsersAndAccounts < ActiveRecord::Migration
  def change

    create_table 'users', :force => true do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.string 'name'
      t.string 'nickname'
      t.string 'email'
      t.string 'crypted_password'
      t.string 'password_salt'
      t.string 'persistence_token', :null => false
      t.string 'single_access_token', :null => false
      t.string 'perishable_token', :null => false
      t.integer 'login_count', :default => 0, :null => false
      t.integer 'failed_login_count', :default => 0, :null => false
      t.datetime 'last_request_at'
      t.datetime 'current_login_at'
      t.datetime 'last_login_at'
      t.string 'current_login_ip'
      t.string 'last_login_ip'
      t.string 'photo_url'
      t.string 'small_photo_url'
      t.boolean 'active', :default => false, :null => false
      t.string 'location'
      t.string 'address_1'
      t.string 'address_2'
      t.string 'city'
      t.string 'state'
      t.string 'zip'
      t.string 'country'
      t.string 'info'
      t.string 'website_name'
      t.string 'website_url'
          t.boolean 'admin'
      t.timestamps
    end

    add_index 'users', 'email'
    add_index 'users', 'single_access_token'

    create_table 'accounts', :force => true do |t|
      t.integer 'user_id'
      t.integer 'platform_id'
      t.integer 'fbapp_id'
      t.string 'provider'
      t.string 'uid'
      t.string 'gplus_id'
      t.string 'token', :limit => 1024
      t.string 'secret'
      t.string 'name'
      t.string 'nickname'
      t.string 'email'
      t.string 'link'
      t.string 'photo_url'
      t.string 'small_photo_url'
      t.timestamps
    end

    add_index 'accounts', ['email']
    add_index 'accounts', ['uid']
    add_index 'accounts', ['user_id', 'platform_id', 'fbapp_id']

    create_table 'platforms', :force => true do |t|
      t.string 'name'
      t.string 'make'
      t.string 'link'
      t.string 'logo'
      t.string 'url_regexp'
      t.string 'userpic'
    end

    add_index 'platforms', ['name'], :name => 'index_platforms_on_name'

  end
end
