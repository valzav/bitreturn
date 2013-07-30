#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")
require Rails.root.join('lib/bitcoin_blocks_importer.rb').to_s

$running = true
Signal.trap("TERM") do
  $running = false
end

def dt
  Time.now.to_s(:db)
end

Rails.logger = ActiveSupport::BufferedLogger.new(File.join(root, 'log/updater.log'))
Rails.logger.info "\n#{dt} === updater started ==="

importer = BitcoinBlocksImporter.new('http://blockexplorer.com/q/nethash')

while $running do
  begin
    Rails.logger.info "#{dt} -------------------"
    counter = importer.perform
    Rails.logger.info "#{dt} new blocks: #{counter}"
    puts "new blocks imported: #{counter}"
    sleep(600)
  rescue Exception => msg
    break if msg.class == Interrupt
    Rails.logger.error "#{dt} !!! Error in updater : #{msg.to_s} (#{msg.class})\n#{msg.backtrace.join("\n")}"
    sleep 60
  end
end
