StockCorr::Application.routes.draw do
  resources :stocks
  root to: 'stocks#index'
end
