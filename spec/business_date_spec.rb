
require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When adding days to a date object" do
    before do
      @start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1)
      @results = @client.add_days(place_id: "usa/anchorage", start_date: @start_date, days: 31)
      @first_period = @results[1][0]
    end

    it "returns the expected start date" do
      expect(@first_period.startdate.datetime).to eq(@start_date)
    end

    it "returns the expected end date" do
      end_date = ::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 18)
      expect(@first_period.enddate.datetime).to eq(end_date)
    end

    it "returns the expected amount of included days" do
      expect(@first_period.includeddays).to eq(31)
    end

    it "returns the expected amount of calendar days" do
      expect(@first_period.calendardays).to eq(48)
    end

    it "returns the expected amount of skipped days" do
      expect(@first_period.skippeddays).to eq(17)
    end

    it "returns the expected amount of mondays" do
      expect(@first_period.weekdays.mon).to eq(0)
    end

    it "returns the expected amount of tuesdays" do
      expect(@first_period.weekdays.tue).to eq(0)
    end
    it "returns the expected amount of wednesdays" do
      expect(@first_period.weekdays.wed).to eq(0)
    end

    it "returns the expected amount of thursdays" do
      expect(@first_period.weekdays.thu).to eq(0)
    end

    it "returns the expected amount of fridays" do
      expect(@first_period.weekdays.fri).to eq(0)
    end

    it "returns the expected amount of saturdays" do
      expect(@first_period.weekdays.sat).to eq(7)
    end

    it "returns the expected amount of sundays" do
      expect(@first_period.weekdays.sun).to eq(7)
    end

    it "returns a non-empty list of holidays" do
      expect(@first_period.holidays).to be_truthy
    end
  end

  context "When subtracting days to a date object" do
    before do
      @start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 2, day: 1)
      @results = @client.subtract_days(place_id: "usa/anchorage", start_date: @start_date, days: 31)
      @first_period = @results[1][0]
    end

    it "returns the expected start date" do
      expect(@first_period.startdate.datetime).to eq(@start_date)
    end

    it "returns the expected end date" do
      end_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 15)
      expect(@first_period.enddate.datetime).to eq(end_date)
    end

    it "returns the expected amount of included days" do
      expect(@first_period.includeddays).to eq(31)
    end

    it "returns the expected amount of calendar days" do
      expect(@first_period.calendardays).to eq(48)
    end

    it "returns the expected amount of skipped days" do
      expect(@first_period.skippeddays).to eq(17)
    end

    it "returns the expected amount of mondays" do
      expect(@first_period.weekdays.mon).to eq(0)
    end

    it "returns the expected amount of tuesdays" do
      expect(@first_period.weekdays.tue).to eq(0)
    end
    it "returns the expected amount of wednesdays" do
      expect(@first_period.weekdays.wed).to eq(0)
    end

    it "returns the expected amount of thursdays" do
      expect(@first_period.weekdays.thu).to eq(0)
    end

    it "returns the expected amount of fridays" do
      expect(@first_period.weekdays.fri).to eq(0)
    end

    it "returns the expected amount of saturdays" do
      expect(@first_period.weekdays.sat).to eq(7)
    end

    it "returns the expected amount of sundays" do
      expect(@first_period.weekdays.sun).to eq(7)
    end

    it "returns a non-empty list of holidays" do
      expect(@first_period.holidays).to be_truthy
    end
  end

  context "When adding repeating days to a date object" do
    before do
      @start_date = ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1)
      @results = @client.add_days(place_id: "usa/anchorage", start_date: @start_date, days: 31, repeat: 5)
      @first_period = @results[1][0]
      @second_period = @results[1][1]
      @third_period = @results[1][2]
      @fourth_period = @results[1][3]
      @fifth_period = @results[1][4]
    end

    it "returns a list of 5 periods" do
      expect(@results[1].length).to eq(5)
    end

    it "returns the expected start and end date for the first period" do
      expect(@first_period.startdate.datetime).to eq(@start_date)
      expect(@first_period.enddate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 18))
    end

    it "returns the expected start and end date for the second period" do
      expect(@second_period.startdate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 1, day: 18))
      expect(@second_period.enddate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 3, day: 5))
    end

    it "returns the expected start and end date for the third period" do
      expect(@third_period.startdate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 3, day: 5))
      expect(@third_period.enddate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 4, day: 18))
    end

    it "returns the expected start and end date for the fourth period" do
      expect(@fourth_period.startdate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 4, day: 18))
      expect(@fourth_period.enddate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 6, day: 1))
    end

    it "returns the expected start and end date for the fifth period" do
      expect(@fifth_period.startdate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 6, day: 1))
      expect(@fifth_period.enddate.datetime).to eq(::LibTAD::TADTime::TADDateTime.new(year: 2018, month: 7, day: 17))
    end
  end

  context "When adding days with an invalid repeat amount" do
    it "throws an exception" do
      expect { 
        @client.add_days(place_id: "usa/anchorage", start_date: "2018-04-05", days: [31, 41], repeat: 5)
      }.to raise_exception('["Error: The days parameter must have a single value if repeat parameter is enabled."]')
    end
  end

  context "When adding days with a country and state" do
    before do
      @results = @client.add_days(country: "us", state: "us-nv", start_date: ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 1), days: 31)
    end

    it "returns the expected state name" do
      expect(@results[0].state).to eq("Nevada")
    end

    it "returns the expected country" do
      expect(@results[0].country.name).to eq("United States")
    end
  end

  context "When adding multiple days and filtering by weekday" do
    before do
      @results = @client.add_days(
        place_id: "usa/anchorage",
        start_date: ::LibTAD::TADTime::TADDateTime.new(year: 2017, month: 12, day: 01),
        days: [31, 41],
        filter: [:mon, :tue]
      )
    end

    it "returns the expected amount of weekdays" do
      expect(@results[1].all? { |e| e.weekdays.mon > 0 }).to be true
      expect(@results[1].all? { |e| e.weekdays.tue > 0 }).to be true
      expect(@results[1].all? { |e| e.weekdays.wed == 0 }).to be true
      expect(@results[1].all? { |e| e.weekdays.thu == 0 }).to be true
      expect(@results[1].all? { |e| e.weekdays.fri == 0 }).to be true
      expect(@results[1].all? { |e| e.weekdays.sat == 0 }).to be true
      expect(@results[1].all? { |e| e.weekdays.sun == 0 }).to be true
    end
  end
end
