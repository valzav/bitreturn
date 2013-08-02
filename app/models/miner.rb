class Miner < ActiveRecord::Base
  belongs_to :user
  has_many 'assets', as: 'assetable'
  attr_accessible :name, :price, :currency, :ghps, :power_use_watt, :availability, :country_of_origin

  monetize :price_cents

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

end
