class MarketEnv < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user, :monthly_growth, :investment_horizon, :usd_btc_rate,
                  :cur_speed, :cur_difficulty, :power_cost, :pool_fee
  attr_accessor :cur_speed, :cur_difficulty
  attr_reader :model, :data_hashes, :data_difficulty, :data_f_hashes, :data_f_difficulty

  def self.get_usd_btc_rate
    ticker_url = 'http://data.mtgox.com/api/1/BTCUSD/ticker_fast'
    json = JSON.parse(open(ticker_url).read)
    return json['return']['last_local']['value'].to_f
  end

  def initialize(attributes = nil, options = {})
    super
    self.usd_btc_rate = MarketEnv.get_usd_btc_rate unless attributes[:usd_btc_rate]
    self.power_cost = 0.15 / self.usd_btc_rate unless attributes[:power_cost]
    self.pool_fee = 0.02 unless attributes[:pool_fee]
  end

  def forecast!
    @model = BitcoinDifficultyModel.new
    blocks_data = Bitcoin::Block.select('block_date, block_time, ghps, difficulty').where("block_time>'2013-01-01'").order('id')
    blocks_data.each do |b|
      @model.add_block(b.block_date, b.block_time, b.difficulty, b.ghps)
    end

    res = @model.forecast(monthly_growth, investment_horizon)
    @cur_speed = "%.02f" % (res[:cur_speed]/1000.0)
    @cur_difficulty = "%.02f" % (res[:cur_difficulty]/1000000.0)
    @usd_btc_rate = "%.02f" % MarketEnv.get_usd_btc_rate

    @data_hashes = []; @data_difficulty = []; @data_f_hashes = []; @data_f_difficulty = []
    @model.blocks.each do |b|
      tt = b.time.to_date.to_s(:number).to_i
      if b.ghps
        @data_hashes << [tt, (b.ghps/1000.0).round(2)]
        @data_difficulty << [tt, (b.difficulty/1000000.0).round(2)]
      elsif b.f_ghps
        @data_f_hashes << [tt, (b.f_ghps/1000.0).round(2)]
        @data_f_difficulty << [tt, (b.f_difficulty/1000000.0).round(2)]
      end
    end
  end

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

end