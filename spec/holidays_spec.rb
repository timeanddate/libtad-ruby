require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting holidays for a specific country and year" do
    before do
      @results = @client.get_holidays(year: 2014, country: "us")
      @first_holiday = @results[0]
    end

    it "returns a holiday" do
      expect(@first_holiday).to be_truthy
    end

    it "returns the expected holiday name" do
      expect(@first_holiday.name["en"]).to eq("New Year's Day")
    end

    it "returns the expected holiday uid" do
      expect(@first_holiday.uid).to eq("0007d600000007de")
    end

    it "returns the expected holiday url" do
      expect(@first_holiday.url).to eq("https://www.timeanddate.com/holidays/us/new-year-day")
    end

    it "returns the expected holiday id" do
      expect(@first_holiday.id).to eq(2006)
    end
  end

  context "When requesting holidays for a specific country and year filtered by specific types" do
    before do
      @results = @client.get_holidays(year: 2014, country: "us", types: [:christian, :buddhism])
      @first_holiday = @results[0]
    end

    it "returns 25 holidays" do
      expect(@results.length).to eq(25)
    end

    it "returns a list of holidays of the specific types only" do
      result = @results.all? { |e| e.types.include?("Christian") || e.types.include?("Buddhism") }
      expect(result).to be true
    end

    it "returns a list of holidays with the specified country only" do
      result = @results.all?{ |e| e.country.id == "us" }
      expect(result).to be true
    end

    it "returns a description" do
      expect(@first_holiday.oneliner.empty?).to be false
    end

    it "returns a uid" do
      expect(@first_holiday.uid).to be_truthy
    end

    it "returns a url" do
      expect(@first_holiday.url).to be_truthy
    end
  end

  context "When requesting holidays with time zone information" do
    before do
      @results = @client.get_holidays(year: 2021, types: :seasons, country: "us", timezone: true)
    end

    it "returns time zone information" do
      expect(@results.all? { |e| e.date.timezone.nil? }).to be false
    end
  end

  context "When requesting holidays without time zone information" do
    before do
      @results = @client.get_holidays(year: 2021, types: :seasons, country: "us", timezone: false)
    end

    it "returns time zone information" do
      expect(@results.all? { |e| e.date.timezone.nil? }).to be true
    end
  end
end
