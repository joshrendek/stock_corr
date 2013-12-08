json.array!(@stocks) do |stock|
  json.extract! stock, :symbol, :open, :low, :close, :volume, :stock_data
  json.high (stock.high || stock.stock_data['days_high']).to_f
  json.low (stock.low|| stock.stock_data['days_low']).to_f
  json.close (stock.close || stock.stock_data['previous_close']).to_f

  json.url stock_url(stock, format: :json)
end
