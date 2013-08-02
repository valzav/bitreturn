class User < ActiveRecord::Base
  has_many :accounts, :dependent => :destroy
  has_many :assets

  attr_accessible :name, :first_name, :last_name, :email, :address_1, :address_2, :city, :state, :zip, :country
  attr_accessible :website_name, :website_url, :nickname, :password, :password_confirmation, :single_access_token, :active
  validates_uniqueness_of :email, :case_sensitive => false, allow_blank: true

  #AUTH_PROVIDERS = ['etsy'] #['etsy', 'facebook', 'google', 'twitter']

  acts_as_authentic
  #do |c|
  #  c.validate_login_field = false
  #  c.validate_email_field = true
  #  c.validate_password_field = true
  #end

  def self.get_user_for_login_via_omniauth(omniauth, current_user)
    account = Account.find_or_create_from_omniauth(omniauth)
    # logger.info "----get_user_for_login_via_omniauth: Account: #{account.inspect}, current_user: #{current_user.inspect}"
    user = current_user ? current_user : User.find_or_create_using_account(account)
    if account.user.nil?
      account.user = user
    else
      if account.user_id != user.id
        user.move_accounts_from_old_user(account.user)
        account.user = user
      end
    end
    account.save!
    user.reload unless user.new_record?
    user.update_from_account!(account)
    user.active = true
    user.save!
    user
  end

  def self.find_or_create_using_account(account)
    return account.user if account.user
    user = User.find_by_email(account.email) if account.email
    user || User.new
  end

  def update_from_account!(account)
    self.email = account.email if self.email.blank?
    self.name = account.name if self.name.blank?
    self.nickname = account.nickname if self.nickname.blank?
    self.photo_url = account.photo_url if self.photo_url.blank?
    self.small_photo_url = account.small_photo_url if self.small_photo_url.blank?
  end

  def main_fb_account
    return @main_fb_account if @main_fb_account
    #@main_fb_account = self.accounts.find_by_platform_id_and_fbapp_id(Platform.facebook.id, Fbapp.main.id)
    @main_fb_account = self.accounts.find_by_platform_id(Platform.facebook.id)
    @main_fb_account ||= self.accounts.first
  end

  def koala
    @koala ||= Koala::Facebook::API.new(self.main_fb_account.token)
  end

  #def fbapp_koala(fbapp)
  #  account = self.accounts.find_by_platform_id_and_fbapp_id(Platform.facebook.id, fbapp.id)
  #  return account ? Koala::Facebook::API.new(account.token) : nil
  #end

  def move_accounts_from_old_user(old_user)
    old_user.accounts.each do |a|
      logger.debug "--- info account #{a.inspect} to new user_id=#{self.id}"
      a.update_attribute(:user_id, self.id)
    end
  end

  def fb_id=(value)
    return false if value.blank? or self.main_fb_account
    info = Account.get_facebook_info(value)
    account = self.accounts.build(info.merge(provider: 'facebook', platform: Platform.facebook, fbapp: Fbapp.main))
    self.active = true
    update_from_account!(account)
    return true
  end

  def fb_id
    a = self.main_fb_account
    return a ? a.uid : ''
  end

  def test_user?
    self.email == 'user@example.com' || self.email == 'valentine.zavgorodnev@gmail.com'
  end

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

  def facebook_account
    accounts.where(provider: 'facebook').first ||
    nil
  end

end

