class DifModelSerializer < ActiveModel::Serializer
  attributes :monthly_growth, :investment_horizon, :data_hashes, :data_difficulty, :data_f_hashes, :data_f_difficulty

end
