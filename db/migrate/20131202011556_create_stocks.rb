class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.float :volume
      t.hstore :stock_data

      t.timestamps
    end
  end
end
