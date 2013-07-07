require 'spec_helper'

describe User do
  # it "should be created from facebooks's omniauth" do
  #    #login using facebook oauth, should use email to bind to existing user
  #    omniauth = load_yaml('omniauth_facebook.yml')
  #    user = User.get_user_for_login_via_omniauth(omniauth, nil)
  #    user.accounts.size.should == 1
  #    user.name.should == 'Slonya Potamsky'
  # end

  let(:user) do
    User.create(email: 'a@example.com', password: '123456', password_confirmation: '123456')
  end

end
