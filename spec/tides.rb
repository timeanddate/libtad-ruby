require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting tidal data for a specific interval" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/stavanger", start_date: "2021-09-08T00:00:00", end_date: "2021-09-08T23:59:59")
    end

    it "returns results for a single station" do
      expect(@result.length).to eq(1)
    end

    it "returns the expected station name" do
      expect(@result[0].source.name).to eq("Stavanger")
    end

    it "returns the expected station type" do
      expect(@result[0].source.type).to eq("Reference Station")
    end

    it "returns the expected matchparam" do
      expect(@result[0].matchparam).to eq("norway/stavanger")
    end


    it "returns correct month and day for every data point" do
      expect(@result[0].result.all? { |d| d.time.datetime.month == 9 and d.time.datetime.day == 8 }).to be true
    end

    it "returns only high and low points" do
      expect(@result[0].result.all? { |d| d.phase == "high" or d.phase == "low" }).to be true
    end
  end

  context "When requesting tidal data without only highs and lows" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/stavanger", onlyhighlow: false)
    end

    it "returns flow and ebb as well as high and low" do
      expect(@result[0].result.any? { |d| d.phase == "flow" or d.phase == "ebb" }).to be true
    end
  end

  context "When requesting data for a subordinate station" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/sola", subordinate: true)
    end

    it "returns results for a subordinate station" do
      expect(@result[0].source.type).to eq("Subordinate Station")
    end
  end

  context "When requesting data without a radius" do
    it "returns an error" do
      expect { @client.get_tidal_data(placeid: "4") }.to raise_error (Exception)
    end
  end

  context "When requesting data with a radius" do
    before do
      @result = @client.get_tidal_data(placeid: "4", radius: 186)
    end

    it "returns results" do
      expect(@result).to be_truthy
    end
  end

  context "When requesting data in intervals of 60 minutes" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/stavanger", interval: 60, onlyhighlow: false)
    end

    it "returns 24 data points" do
      expect(@result[0].result.length).to eq(24)
    end
  end

  context "When requesting data in intervals of 30 minutes" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/stavanger", interval: 30, onlyhighlow: false)
    end

    it "returns 48 data points" do
      expect(@result[0].result.length).to eq(48)
    end
  end

  context "When requesting data in intervals of 15 minutes" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/stavanger", interval: 15, onlyhighlow: false)
    end

    it "returns 96 data points" do
      expect(@result[0].result.length).to eq(96)
    end
  end
  
  context "When requesting data in intervals of 5 minutes" do
    before do
      @result = @client.get_tidal_data(placeid: "norway/stavanger", interval: 5, onlyhighlow: false)
    end

    it "returns 288 data points" do
      expect(@result[0].result.length).to eq(288)
    end
  end
end
