require 'net/ftp'
namespace :stocks do

  desc "load from data/stock_symbols"
  task :load => :environment do

    ftp = Net::FTP.new('ftp.nasdaqtrader.com')
    ftp.login
    stocks = ftp.gettextfile('SymbolDirectory/nasdaqlisted.txt', nil).split(/\n/).map { |x| x.split("|") }
# ["Symbol",
  # "Security Name",
  # "Market Category",
  # "Test Issue",
  # "Financial Status",
  # "Round Lot Size"]

    stocks[1..-1].each do |symbol, security_name, market_category, test_issue, financial_status, round_lot_size|
      p "Parsing: #{symbol} - #{security_name}"
      begin
        s = Stocks::FetchQuotes.new(symbol)
        s.save
      rescue => e
        p "Error: #{e}"
      end
    end
  end

end
