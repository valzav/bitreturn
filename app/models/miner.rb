class Miner < ActiveRecord::Base
  has_many 'assets', as: 'assetable'
  attr_accessible :name, :usd_price, :btc_price, :ghps, :power_use_watt, :availability, :country_of_origin

end
