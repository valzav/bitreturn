#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require 'bitcoin_difficulty_model'
require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do
  $running = false
end

def dt
  Time.now.to_s(:db)
end

Rails.logger = ActiveSupport::BufferedLogger.new(File.join(root, 'log/updater.log'))
Rails.logger.info "\n#{dt} === updater started ==="

while $running do
  begin
    Rails.logger.info "#{dt} -------------------"
    last_block = Bitcoin::Block.last
    last_block_number = last_block ? last_block.block_number : 0
    import = BitcoinDifficultyModel::BlocksImport.new('http://blockexplorer.com/q/nethash', last_block_number)
    counter = 0
    import.each_block do |b|
      Bitcoin::Block.create!(block_number: b.number, block_date: b.date, block_time: b.time, difficulty: b.difficulty, ghps: b.ghps)
      counter += 1
    end
    Rails.logger.info "#{dt} new blocks: #{counter}"
    puts "new blocks imported: #{counter}"
    sleep(600)
  rescue Exception => msg
    break if msg.class == Interrupt
    Rails.logger.error "#{dt} !!! Error in updater : #{msg.to_s} (#{msg.class})\n#{msg.backtrace.join("\n")}"
    sleep 60
  end
end
