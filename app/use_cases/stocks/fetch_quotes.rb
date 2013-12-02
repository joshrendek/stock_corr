require 'stock_quote'
module Stocks
  class FetchQuotes
    attr_accessor :symbol, :stock
    def initialize(symbol)
      self.symbol = symbol
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

    end
  end
end
