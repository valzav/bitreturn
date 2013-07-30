class Security < ActiveRecord::Base
  has_many 'assets', as: 'assetable'
  # attr_accessible :title, :body

end
