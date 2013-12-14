require 'net/ftp'
namespace :stocks do

  desc "load from data/stock_symbols"
  task :load => :environment do
    StockRefresher.new.run
  end

end
