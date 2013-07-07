class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :single_access_token, :address_1, :address_2, :city, :state, :zip, :country,
             :website_showlink, :website_name, :website_url

  def attributes
    attrs = super
    attrs.each {|k,v| attrs[k] = '' if v.nil? }
    attrs
  end

end
