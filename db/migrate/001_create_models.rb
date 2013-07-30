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

    create_table :dif_models do |t|

      t.timestamps
    end


    create_table :miners do |t|
      t.string 'name'
      t.float 'btc_price'
      t.float 'usd_price'
      t.float 'ghps'
      t.float 'power_use_watt'
      t.string 'availability'
      t.string 'country_of_origin'
      t.timestamps
    end

    create_table :securities do |t|
      t.timestamps
    end

    create_table :assets do |t|
      t.references 'assetable', polymorphic: true
      t.string 'name'
      t.date 'purchase_date'
      t.date 'effective_date'
      t.float 'btc_price'
      t.float 'usd_price'
      #t.integer 'pool_fee_percent'

      t.timestamps
    end


  end
end
