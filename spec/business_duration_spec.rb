

require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting a business duration" do
    before do
      start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1)
      end_date = ::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 31)
      @results = @client.get_duration(start_date: start_date, end_date: end_date, place_id: "usa/anchorage")
    end

    it "returns the expected geographical name" do
      expect(@results[0].name).to eq("Anchorage")
    end

    it "returns the expected calendar days" do
      expect(@results[1].calendardays).to eq(61)
    end

    it "returns the expected skipped days" do
      expect(@results[1].skippeddays).to eq(21)
    end

    it "returns the expected included days" do
      expect(@results[1].includeddays).to eq(40)
    end

    it "returns the expected amount of saturdays" do
      expect(@results[1].weekdays.sat).to eq(9)
    end

    it "returns the expected amount of sundays" do
      expect(@results[1].weekdays.sun).to eq(9)
    end

    it "returns the expected amount of holidays" do
      expect(@results[1].holidays.count).to eq(3)
    end
  end

  context "When requesting a business duration with including" do
    before do
      start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1)
      end_date = ::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 31)
      @results = @client.get_duration(start_date: start_date, end_date: end_date, place_id: "usa/anchorage", including: true)
    end

    it "returns the expected geographical name" do
      expect(@results[0].name).to eq("Anchorage")
    end

    it "returns the expected amount of calendar days" do
      expect(@results[1].calendardays).to eq(61)
    end

    it "returns the expected amount of skipped days" do
      expect(@results[1].skippeddays).to eq(40)
    end

    it "returns the expected amount of included days" do
      expect(@results[1].includeddays).to eq(21)
    end

    it "returns the expected amount of saturdays" do
      expect(@results[1].weekdays.sat).to eq(9)
    end

    it "returns the expected amount of sundays" do
      expect(@results[1].weekdays.sun).to eq(9)
    end

    it "returns the expected amount of holidays" do
      expect(@results[1].holidays.count)
    end
  end

  context "When requesting a business duration with include_last_date" do
    before do
      start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1)
      end_date = ::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 31)
      @results = @client.get_duration(start_date: start_date, end_date: end_date, place_id: "usa/anchorage", include_last_date: true)
    end

    it "returns the expected geographical name" do
      expect(@results[0].name).to eq("Anchorage")
    end

    it "returns the expected amount of calendar days" do
      expect(@results[1].calendardays).to eq(62)
    end

    it "returns the expected amount of skipped days" do
      expect(@results[1].skippeddays).to eq(21)
    end

    it "returns the expected amount of included days" do
      expect(@results[1].includeddays).to eq(41)
    end
  end

  context "When requesting a business duration and filtering by weekday" do
    before do
      start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1)
      end_date = ::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 31)
      @results = @client.get_duration(start_date: start_date, end_date: end_date, place_id: "usa/anchorage", filter: [:mon, :tue])
    end

    it "returns the expected geographical name" do
      expect(@results[0].name).to eq("Anchorage")
    end

    it "returns the expected amount of calendar days" do
      expect(@results[1].calendardays).to eq(61)
    end

    it "returns the expected amount of skipped days" do
      expect(@results[1].skippeddays).to eq(18)
    end

    it "returns the expected amount of included days" do
      expect(@results[1].includeddays).to eq(43)
    end

    it "returns the expected amount of mondays" do
      expect(@results[1].weekdays.mon).to eq(9)
    end

    it "returns the expected amount of tuesdays" do
      expect(@results[1].weekdays.tue).to eq(9)
    end

    it "returns the expected amount of wednesdays" do
      expect(@results[1].weekdays.wed).to eq(0)
    end

    it "returns the expected amount of thursdays" do
      expect(@results[1].weekdays.thu).to eq(0)
    end

    it "returns the expected amount of fridays" do
      expect(@results[1].weekdays.fri).to eq(0)
    end

    it "returns the expected amount of saturdays" do
      expect(@results[1].weekdays.sat).to eq(0)
    end

    it "returns the expected amount of sundays" do
      expect(@results[1].weekdays.sun).to eq(0)
    end
  end
end
