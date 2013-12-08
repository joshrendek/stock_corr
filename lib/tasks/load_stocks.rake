namespace :stocks do

  desc "load from data/stock_symbols"
  task :load => :environment do
    stocks = IO.readlines('./data/stock_symbols.csv').map{ |x| x.split(",").map(&:strip) }
    stocks.each do |company, symbol, market, country|
      p "Parsing: #{symbol}"
      begin
        s = Stocks::FetchQuotes.new(symbol)
        s.save
      rescue => e
        p "Error: #{e}"
      end
    end
  end

end
