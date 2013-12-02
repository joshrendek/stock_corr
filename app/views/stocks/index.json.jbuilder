json.array!(@stocks) do |stock|
  json.extract! stock, :symbol, :open, :high, :low, :close, :volume, :stock_data
  json.url stock_url(stock, format: :json)
end
