require 'stock_quote'
module Stocks
  class FetchQuotes
    attr_accessor :symbol, :stock, :name, :category, :financial_status
    def initialize(symbol, name, category, financial_status)
      self.symbol = symbol
      self.name = name
      self.category = category
      self.financial_status = financial_status
      latest
    end

    def latest
      self.stock = StockQuote::Stock.quote(symbol)
      to_hash
    end

    def to_hash
      methods = self.stock.instance_variables.collect { |x| x.to_s.gsub("@", "") }
      Hash[methods.map { |x| [x, stock.send(x.to_sym)] }]
    end

    def save
      h = to_hash
      stock_model = Stock.where(symbol: symbol).first_or_create

      if stock_model.stock_data.present?
        p "Creating history"
        stock_model.stock_histories.create(stock_id: stock_model.id,
                                           stock_data: stock_model.stock_data)
        # StockHistory.create(
          # stock_id: stock_model.id,
          # stock_data: stock_model.stock_data
        # )
      end

      stock_model.symbol = symbol
      stock_model.name = name
      stock_model.category = category
      stock_model.financial_status = financial_status
      stock_model.open = h['open']
      stock_model.high = h['high']
      stock_model.low = h['low']
      stock_model.close = h['close']
      stock_model.volume = h['volume']
      stock_model.stock_data = h

      stock_model.save
    end
  end
end
