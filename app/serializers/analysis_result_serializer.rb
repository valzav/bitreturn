class AnalysisResultSerializer < ActiveModel::Serializer
  attributes :id, :power_cost, :pool_fee, :gross_income, :net_income, :roi, :expenses, :cashflows

  def process_timeseries_array(array)
    return [] if array.nil?
    array.map { |i| [Date.parse(i[0].to_s).to_datetime.to_i*1000, i[1]] }
  end

  def cashflows
    process_timeseries_array(object.cashflows)
  end

end
