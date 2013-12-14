require 'net/ftp'
class StockRefresher
  include SuckerPunch::Job
  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      ftp = Net::FTP.new('ftp.nasdaqtrader.com')
      ftp.login
      stocks = ftp.gettextfile('SymbolDirectory/nasdaqlisted.txt', nil).split(/\n/).map { |x| x.split("|") }

      stocks[1..-2].each do |symbol, security_name, market_category, test_issue, financial_status, round_lot_size|
        Rails.logger.info "Parsing: #{symbol} - #{security_name}"
        begin
          s = Stocks::FetchQuotes.new(symbol, security_name, market_category, financial_status)
          s.save
        rescue => e
          p "Error: #{e}"
        end
      end
    end
    sleep 900
    StockRefresher.new.async.perform
  end

  def on_error(exception)

  end
end
