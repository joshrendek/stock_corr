require 'spec_lite'
require './app/use_cases/stocks/fetch_quotes'

class Stock
end

describe Stocks::FetchQuotes do
  subject { Stocks::FetchQuotes }
  context "retrieving quotes" do
    it "should call the stock quote api" do
      s = subject.new('GOOG')
      StockQuote::Stock.should_receive(:quote)
      s.latest
    end
    it "should get the latest quotes for GOOGLE" do
      s = subject.new('GOOG')
      s.latest
      expect(s.to_hash.keys.count).to eq(82)
    end
  end

  context "saving quotes" do
    it "should save to the db" do
      model = double("stock")
      model.stub(:save)
      allow(Stock).to receive(:new).and_return(model)
      # expect(model).to have_received(:save)
      s = subject.new('GOOG')
      s.save
    end
  end
end
