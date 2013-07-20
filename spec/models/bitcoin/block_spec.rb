require 'spec_helper'
require Rails.root.join('lib/bitcoin_blocks_importer.rb').to_s
require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s

describe Bitcoin::Block do

  it 'should be able to import data from csv' do
    filepath ='file://' + Rails.root.join('spec/test_data', 'blocks_nethash.txt').to_s
    importer = BitcoinBlocksImporter.new(filepath)
    counter = importer.perform
    counter.should == 1486
    Bitcoin::Block.last.block_number.should == 247104
  end

end

describe BitcoinDifficultyModel do

  it 'should work' do
    filepath ='file://' + Rails.root.join('spec/test_data', 'blocks_nethash.txt').to_s
    importer = BitcoinBlocksImporter.new(filepath)
    importer.perform
    blocks_data = Bitcoin::Block.where("block_time>'2013-01-01'").order('id')
    model = BitcoinDifficultyModel.new
    blocks_data.each do |b|
      model.add_block(b.block_date, b.block_time, b.difficulty, b.ghps)
    end
    len1 = model.blocks.length
    res = model.forecast(360,40.0)
    len2 = model.blocks.length
    (len2 - len1).should == 360
    File.open(Rails.root.join('spec/test_data/blocks_forecast.yml'),'w'){|f| f.write model.blocks_to_array.to_yaml}
  end

end

