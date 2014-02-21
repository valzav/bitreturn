require 'bitcoin_difficulty_model'

class MarketEnv < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user, :monthly_growth, :investment_horizon, :usd_btc_rate,
                  :cur_speed, :cur_difficulty, :power_cost, :pool_fee
  attr_accessor :cur_speed, :cur_difficulty
  attr_reader :data_hashes, :data_difficulty, :data_f_hashes, :data_f_difficulty

  def self.get_usd_btc_rate
    ticker_url = 'https://api.bitcoinaverage.com/ticker/global/USD/last'
    unless @curl
      @curl = Curl::Easy.new
      @curl.follow_location = true
      @curl.max_redirects = 3
      @curl.useragent = 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 GTB5'
    end
    @curl.url = ticker_url
    @curl.perform
    #json = JSON.parse(@curl.body_str)
    #return json['return']['last_local']['value'].to_f
    return @curl.body_str.to_f
  end

  def initialize(attributes = nil, options = {})
    super
    @usd_btc_rate = MarketEnv.get_usd_btc_rate #unless attributes[:usd_btc_rate]
    self.power_cost = 0.15 / self.usd_btc_rate unless attributes[:power_cost]
    self.pool_fee = 0.02 unless attributes[:pool_fee]
  end

  def usd_btc_rate
    @usd_btc_rate ||= MarketEnv.get_usd_btc_rate
    @usd_btc_rate.to_f
  end

  def forecast
    bb = BitcoinDifficultyModel::Block
    blocks_data = Bitcoin::Block.select('block_number, block_date, block_time, ghps, difficulty').where("block_time>'2013-01-01'").order('id')
    raise "No blocks found\nPlease run\nrake daemon:updater" if blocks_data.empty?
    blocks = blocks_data.map{|b| bb.new(b.block_number, b.block_date, b.block_time, b.difficulty, b.ghps) }
    res = BitcoinDifficultyModel.forecast(blocks, investment_horizon, monthly_growth)
    @cur_speed = "%.02f" % (res[:cur_speed]/1000.0)
    @cur_difficulty = "%.02f" % (res[:cur_difficulty]/1000000.0)
    @usd_btc_rate = "%.02f" % MarketEnv.get_usd_btc_rate

    @data_hashes = []; @data_difficulty = []; @data_f_hashes = []; @data_f_difficulty = []
    res[:blocks].each do |b|
      tt = b.time.to_date.to_s(:number).to_i
      if b.ghps
        @data_hashes << [tt, (b.ghps/1000.0).round(2)]
        @data_difficulty << [tt, (b.difficulty/1000000.0).round(2)]
      elsif b.f_ghps
        @data_f_hashes << [tt, (b.f_ghps/1000.0).round(2)]
        @data_f_difficulty << [tt, (b.f_difficulty/1000000.0).round(2)]
      end
    end
    return res
  end

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

end
