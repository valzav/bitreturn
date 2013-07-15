class CreateModels < ActiveRecord::Migration
  def change
    create_table :bitcoin_blocks do |t|
      t.integer 'block_number'
      t.date 'block_date'
      t.timestamp 'block_time'
      t.string 'target'
      t.float 'difficulty'
      t.float 'ghps'
    end
    add_index 'bitcoin_blocks', 'block_number'
  end
end
