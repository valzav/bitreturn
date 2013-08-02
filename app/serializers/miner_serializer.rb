class MinerSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :currency, :ghps, :power_use_watt, :availability

  def price
    "#{object.price.to_f} #{object.currency}"
  end

end
