class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :single_access_token

  #def attributes
  #  attrs = super
  #  attrs.each {|k,v| attrs[k] = '' if v.nil? }
  #  attrs
  #end

end
