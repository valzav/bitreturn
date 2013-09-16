class AnalysisResult < ActiveRecord::Base
  attr_accessor :ars, :asset_name
  belongs_to :asset
  attr_accessible :asset_id, :ars, :asset_name, :power_cost, :pool_fee, :gross_income, :expenses, :net_income, :roi, :asset_btc_price, :cashflows

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

end
