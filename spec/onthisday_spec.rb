require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting holidays for a specific day and month" do
    before do
      @events, @births, @deaths = @client.get_events_on_this_day(month: 5, day: 24)
      @first_event = @events[0]
      @first_birth = @births[0]
      @first_death = @deaths[0]
    end

    it "returns an event, birth and death" do
      expect(@first_event).to be_truthy
      expect(@first_birth).to be_truthy
      expect(@first_death).to be_truthy
    end

    it "returns the expected month and day" do
      expect(@first_event.date.datetime.month).to eq(5)
      expect(@first_event.date.datetime.day).to eq(24)

      expect(@first_birth.birthdate.datetime.month).to eq(5)
      expect(@first_birth.birthdate.datetime.day).to eq(24)

      expect(@first_death.deathdate.datetime.month).to eq(5)
      expect(@first_death.deathdate.datetime.day).to eq(24)
    end

    it "returns an event description" do
      expect(@first_event.description["en"]).to be_truthy
    end

    it "returns an event name" do
      expect(@first_event.name["en"]).to be_truthy
    end

    it "returns an event location" do
      expect(@first_event.location).to be_truthy
    end

    it "returns a list of event categories" do
      expect(@first_event.categories).to be_truthy
    end

    it "returns a list of related countries" do
      expect(@first_event.countries).to be_truthy
    end

    it "returns a name of a person" do
      expect(@first_death.name).to be_truthy
    end
  end

  context "When requesting deaths only" do
    before do
      @events, @births, @deaths = @client.get_events_on_this_day(types: [:deaths])
    end

    it "returns a list of deaths" do
      expect(@deaths.length).to be > 0
    end

    it "does not return a list of events" do
      expect(@events.length).to eq(0)
    end

    it "does not return a list of births" do
      expect(@births.length).to eq(0)
    end
  end

  context "When requesting births only" do
    before do
      @events, @births, @deaths = @client.get_events_on_this_day(types: [:births])
    end

    it "returns a list of births" do
      expect(@births.length).to be > 0
    end

    it "does not return a list of events" do
      expect(@events.length).to eq(0)
    end

    it "does not return a list of deaths" do
      expect(@deaths.length).to eq(0)
    end
  end

  context "When requesting events only" do
    before do
      @events, @births, @deaths = @client.get_events_on_this_day(types: [:events])
    end

    it "returns a list of events" do
      expect(@events.length).to be > 0
    end

    it "does not return a list of births" do
      expect(@births.length).to eq(0)
    end

    it "does not return a list of deaths" do
      expect(@deaths.length).to eq(0)
    end
  end
end
