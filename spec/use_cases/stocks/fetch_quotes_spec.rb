require 'spec_lite'
require './app/use_cases/stocks/fetch_quotes'

describe Stocks::FetchQuotes do
  subject { Stocks::FetchQuotes }
  context "retrieving quotes" do
    it "should get the latest quotes for GOOGLE" do
      s = subject.new('GOOG')
      s.latest
      expect(s.to_hash.keys.count).to eq(82)
    end
  end
end
