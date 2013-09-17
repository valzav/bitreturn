class AnalysisResultSerializer < ActiveModel::Serializer
  attributes :id, :asset_id, :asset_name, :power_cost, :pool_fee, :gross_income,
             :net_income, :roi, :expenses, :cashflows, :ars, :asset_btc_price

  def process_timeseries_array(array)
    return [] if array.nil?
    array.map { |i| [Date.parse(i[0].to_s).to_datetime.to_i*1000, i[1]] }
  end

  def process_objects_array(array)
    return [] if array.nil?
    array.map { |i| i.serializer }
  end

  def cashflows
    process_timeseries_array(object.cashflows)
  end

  def ars
    process_objects_array(object.ars)
  end

end
