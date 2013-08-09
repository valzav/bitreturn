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
      t.integer 'user_id'
      t.string 'name'
      t.integer 'price_cents', limit: 8
      t.string 'currency'
      t.float 'ghps'
      t.float 'power_use_watt'
      t.string 'availability'
      t.string 'country_of_origin'
      t.boolean 'public'
      t.timestamps
    end

    create_table :securities do |t|
      t.integer 'user_id'
      t.string 'name'
      t.integer 'price_cents', limit: 8
      t.string 'currency'
      t.string 'availability'
      t.string 'country_of_origin'
      t.boolean 'public'
      t.timestamps
      t.timestamps
    end

    create_table :assets do |t|
      t.integer 'user_id'
      t.references 'assetable', polymorphic: true
      t.string 'name'
      t.integer 'quantity'
      t.date 'purchase_date'
      t.date 'effective_date'
      t.integer 'price_cents', limit: 8
      t.string 'currency'
      t.float 'ghps'
      t.float 'power_use_watt'
      t.timestamps
    end

    create_table :market_envs do |t|
      t.integer 'user_id'
      t.date 'date'
      t.float 'usd_btc_rate'
      t.float 'power_cost'
      t.float 'pool_fee'
      t.timestamps
    end

    create_table :analysis_results do |t|
      t.float :power_cost
      t.float :pool_fee
      t.float :gross_income
      t.float :net_income
      t.float :roi
      t.float :expenses
      t.text :cashflows
      t.timestamps
    end

  end
end
