class MinerSerializer < ActiveModel::Serializer
  include MoneyRails::ActionViewExtension
  attributes :id, :name, :price, :price_display, :currency, :ghps, :power_use_watt, :availability

  def price
    object.price.to_f
  end

  def price_display
    humanized_money_with_symbol(object.price).sub(/0+$/, '')
  end


end
