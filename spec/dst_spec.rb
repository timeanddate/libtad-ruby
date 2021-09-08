require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting DST entries for a specific year" do
    before do
      @results = @client.get_daylight_savings_time(year: 2016)
    end
    
    it "returns 129 entries" do
      expect(@results.length).to eq(129)
    end
  end

  context "When requesting DST entries for a specific country" do
    before do
      @results = @client.get_daylight_savings_time(country: "no")
    end

    it "returns the correct country id and name" do
      expect(@results[0].region.country.name).to eq("Norway")
      expect(@results[0].region.country.id).to eq("no")
    end

    it "returns 1 entry" do
      expect(@results.length).to eq(1)
    end
  end
context "When requesting DST entries for a specific country and year" do
    before do
      @results = @client.get_daylight_savings_time(year: 2014, country: "no")
    end

    it "returns the correct country id and name" do
      expect(@results[0].region.country.name).to eq("Norway")
      expect(@results[0].region.country.id).to eq("no")
    end

    it "returns 1 entry" do
      expect(@results.length).to eq(1)
    end
  end

  context "When requesting DST entries with places for every country" do
    before do
      @results = @client.get_daylight_savings_time(list_places: true)
    end

    it "returns place information" do
      expect(@results.all? { |e| e.region.locations.nil? }).to be false
    end
  end

  context "When requesting DST entries without places for every country" do
    before do
      @results = @client.get_daylight_savings_time(list_places: false)
    end

    it "does not return place information" do
      expect(@results.all? { |e| e.region.locations.nil? }).to be true
    end
  end

  context "When requesting DST entries with time changes" do
    before do
      @results = @client.get_daylight_savings_time(time_changes: true)
    end

    it "returns time changes information" do
      expect(@results.all? { |e| e.timechanges.nil? }).to be false
    end
  end

  context "When requesting DST entries without time changes" do
    before do
      @results = @client.get_daylight_savings_time(time_changes: false)
    end

    it "does not return time changes information" do
      expect(@results.all? { |e| e.timechanges.nil? }).to be true
    end
  end

  context "When requesting DST entries with only DST countries" do
    before do
      @results = @client.get_daylight_savings_time(only_dst: true, year: 2014)
    end

    it "returns 132 entries" do
      expect(@results.length).to eq(132)
    end
  end

  context "When requesting DST entries without only DST countries" do
    before do
      @results = @client.get_daylight_savings_time(only_dst: false, year: 2014)
    end

    it "returns 348 entries" do
      expect(@results.length).to eq(348)
    end

    it "returns a non-empty list of only DST countries" do
      count = @results
        .select { |e| !e.special.nil? }
        .select { |e| e.special == "nodst" }
        .length
      expect(count).to be > 0
    end
  end
end
