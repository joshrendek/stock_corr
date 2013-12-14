class AddColumnsToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :name, :string
    add_column :stocks, :category, :string, :size => 1
    add_column :stocks, :financial_status, :string, :size => 1
  end
end
