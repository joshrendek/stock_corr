class Stock < ActiveRecord::Base
  serialize :stock_data, ActiveRecord::Coders::Hstore
end
