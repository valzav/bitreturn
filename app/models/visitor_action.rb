class VisitorAction < ActiveRecord::Base
  attr_accessible :visid, :sesid, :category, :action, :value, :ua, :ip

end
