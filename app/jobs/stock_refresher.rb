class StockRefresher
  def run
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

  def on_error(exception)

  end
end
