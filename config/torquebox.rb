TorqueBox.configure do
  job StockRefresher do
    name 'stock.refresher' # optional, unless the job class is used by multiple jobs
    cron '*/15 * * * * ?'
    timeout '600s'
    description 'Request stock updates' # optional
  end
end
