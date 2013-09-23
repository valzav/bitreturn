class Miner < ActiveRecord::Base
  belongs_to :user
  has_many 'assets', as: 'assetable'
  attr_accessible :name, :price, :currency, :ghps, :power_use_watt, :availability, :country_of_origin

  monetize :price_cents

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

  def self.define(name, price, currency, ghps, power_use)
    Miner.create!({
                    name: name,
                    currency: currency,
                    price: price,
                    ghps: ghps,
                    power_use_watt: power_use
                  })
  end

end
