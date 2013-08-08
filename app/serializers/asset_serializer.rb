class AssetSerializer < ActiveModel::Serializer
  include MoneyRails::ActionViewExtension
  attributes :id, :name, :quantity, :assetable_id, :currency, :price, :price_display, :ghps, :power_use_watt #, :purchase_date, :effective_date

  def price
    object.price.to_f
  end

  def price_display
    humanized_money_with_symbol(object.price).sub(/0+$/, '')
  end

end
