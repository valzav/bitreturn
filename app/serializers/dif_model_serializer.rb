class DifModelSerializer < ActiveModel::Serializer
  attributes :monthly_growth, :investment_horizon, :data_hashes,
             :data_difficulty, :data_f_hashes, :data_f_difficulty,
             :cur_speed, :cur_difficulty, :usd_btc_rate

  def process_timeseries_array(array)
    array.map { |i| [Date.parse(i[0].to_s).to_datetime.to_i*1000, i[1]] }
  end

  def data_hashes
    process_timeseries_array(object.data_hashes)
  end

  def data_difficulty
    process_timeseries_array(object.data_difficulty)
  end

  def data_f_hashes
    process_timeseries_array(object.data_f_hashes)
  end

  def data_f_difficulty
    process_timeseries_array(object.data_f_difficulty)
  end

end
