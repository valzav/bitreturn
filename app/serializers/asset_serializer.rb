class AssetSerializer < ActiveModel::Serializer
  include MoneyRails::ActionViewExtension
  attributes :id, :name, :quantity, :assetable_id, :currency, :price, :price_display, :ghps, :power_use_watt, :purchase_date, :effective_date

  def date_format(date)
    date.nil? ? nil : date.strftime('%m/%d/%Y')
  end

  def purchase_date
    date_format(object.purchase_date)
  end

  def effective_date
    date_format(object.effective_date)
  end

  def price
    object.price.to_f
  end

  def price_display
    humanized_money_with_symbol(object.price).sub(/0+$/, '')
  end

end
