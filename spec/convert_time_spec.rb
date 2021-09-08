require 'date'
require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting a converted time without an id and date" do
    before do
      @datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: "norway/oslo", datetime: @datetime)
      @first_result = @results[1][0]
    end

    it "returns the expected geographical name" do
      expect(@first_result.geo.name).to eq("Oslo")
    end

    it "returns the expected country name" do
      expect(@first_result.geo.country.name).to eq("Norway")
    end

    it "returns the expected request time" do
      expect(@results[0].datetime).to be == @datetime
    end
  end

  context "When requesting a converted time with an id and date" do
    before do
      @datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: 'norway/oslo', to_id: 'usa/anchorage', datetime: @datetime)

      @anchorage = @results[1].find { |e| e.id == "18" }
      @oslo = @results[1].find { |e| e.id == "187" }
    end

    it "returns the expected state" do
      expect(@anchorage.geo.state).to eq("Alaska")
    end

    it "returns the expected names" do
      expect(@anchorage.geo.name).to eq("Anchorage")
      expect(@oslo.geo.name).to eq("Oslo")
    end
    
    it "returns the expected request time" do
      expect(@results[0].datetime).to be == @datetime
    end
  end

  context "When requesting a converted time with time changes" do
    before do
      datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: "norway/oslo", datetime: datetime, time_changes: true)
    end

    it "returns time changes information" do
      expect(@results[1].all? { |e| e.timechanges.nil? }).to be false
    end
  end

  context "When requesting a converted time without time changes" do
    before do
      datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: "norway/oslo", datetime: datetime, time_changes: false)
    end

    it "does not return time changes information" do
      expect(@results[1].all? { |e| e.timechanges.nil? }).to be true
    end
  end

  context "When requesting a converted time with time zone information" do
    before do
      datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: "norway/oslo", datetime: datetime, timezone: true)
    end

    it "returns time zone information" do
      expect(@results[1].all? { |e| e.time.timezone.nil? }).to be false
    end
  end

  context "When requesting a converted time without time zone information" do
    before do
      datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: "norway/oslo", datetime: datetime, timezone: false)
    end

    it "does not return time zone information" do
      expect(@results[1].all? { |e| e.time.timezone.nil? }).to be true
    end
  end

  context "When requesting a converted time with a radius" do
    before do
      datetime = ::LibTAD::TADTime::TADDateTime.new.now
      @results = @client.convert_time(from_id: "+59.914+10.752", datetime: datetime, radius: 50)
    end

    it "returns the expected geographical name" do
      expect(@results[1][0].geo.name).to eq("Oslo")
    end

    it "returns the expected country name" do
      expect(@results[1][0].geo.country.name).to eq("Norway")
    end
  end
end
