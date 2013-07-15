class Bitcoin::Block < ActiveRecord::Base
  attr_accessible :block_number, :block_date, :block_time, :target, :difficulty, :ghps

end
