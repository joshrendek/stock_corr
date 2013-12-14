class CreateStockHistories < ActiveRecord::Migration
  def change
    create_table :stock_histories do |t|
      t.integer :stock_id, index: true
      t.hstore :stock_data

      t.timestamps
    end
  end
end
