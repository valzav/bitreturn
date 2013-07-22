require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s

class DifModel < ActiveRecord::Base
  attr_accessible :monthly_growth, :investment_horizon
  attr_accessor :monthly_growth, :investment_horizon
  attr_reader :data_hashes, :data_difficulty, :data_f_hashes, :data_f_difficulty

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

  def forecast!
    model = BitcoinDifficultyModel.new
    blocks_data = Bitcoin::Block.select('block_date, block_time, ghps, difficulty').where("block_time>'2013-01-01'").order('id')
    blocks_data.each do |b|
      model.add_block(b.block_date, b.block_time, b.difficulty, b.ghps)
    end
    model.forecast(120, monthly_growth)
    @data_hashes = []; @data_difficulty = []; @data_f_hashes = []; @data_f_difficulty = []
    model.blocks.each do |b|
      js_time = b.time.to_i*1000
      if b.ghps
        @data_hashes << [js_time, b.ghps/1000.0]
        @data_difficulty << [js_time, b.difficulty/1000000.0]
      elsif b.f_ghps
        @data_f_hashes << [js_time, b.f_ghps/1000.0]
        @data_f_difficulty << [js_time, b.f_difficulty/1000000.0]
      end
    end
  end

end
