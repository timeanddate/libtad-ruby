
require 'libtad'

RSpec.describe LibTAD::Client do
  context "When requesting astronomy events for all event types" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
    end

    it "returns a result for every request" do
      ::LibTAD::Astronomy::ASTRONOMY_EVENT_CLASS.each do |type|
        result = @client.get_astro_events(object: :moon, place_id: 3, start_date: "2020-03-05", types: type)
        expect(result[0].objects[0].days).to be_truthy
      end
    end
  end

  context "When requesting astronomy events for all objects" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
    end

    it "returns a result for every request, matching the object type" do
      ::LibTAD::Astronomy::ASTRONOMY_OBJECT_TYPE.each do |object|
        result = @client.get_astro_events(object: object, place_id: 3, start_date: "2020-03-05")
        expect(result[0].objects[0].name).to eq(object.to_s)
      end
    end
  end

  context "When requesting astronomy events for multiple days" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      @result = client.get_astro_events(object: :moon, place_id: 3, start_date: "2020-03-01", end_date: "2020-03-20")
      @days = @result[0].objects[0].days
    end

    it "returns a list of 20 days" do
      expect(@days.length()).to eq(20)
    end

    it "returns a date for every day" do
      @days.each do |day|
        expect(day.date).to be_truthy
      end
    end

    it "returns an event for every day" do
      @days.each do |day|
        expect(day.events).to be_truthy
      end
    end

    it "returns an event type for every event" do
      @days.each do |day|
        day.events.each do |event|
          expect(event.type).to be_truthy
        end
      end
    end

    it "returns the azimuth for every event" do
      @days.each do |day|
        day.events.each do |event|
          expect(event.azimuth).to be_truthy
        end
      end
    end
  end

  context "When requesting astronomy events for a specific language" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      @result = client.get_astro_events(object: :sun, place_id: 187, start_date: "2020-03-01", lang: "es")
    end

    it "returns country name in the requested language" do
      expect(@result[0].geo.country.name).to eq("Noruega")
    end
  end

  context "When testing if the request returns expected geographical information for the given place_id" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      @result = client.get_astro_events(object: :moon, place_id: 3, start_date: "2020-03-15")
      @geo = @result[0].geo
    end

    it "returns the expected name" do
      expect(@geo.name).to eq("Acapulco")
    end

    it "returns the expected state" do
      expect(@geo.state).to eq("Guerrero")
    end

    it "returns the expected country id" do
      expect(@geo.country.id).to eq("mx")
    end

    it "returns the expected country name" do
      expect(@geo.country.name).to eq("Mexico")
    end

    it "returns the expected coordinates" do
      expect(@geo.latitude).to eq(16.860)
      expect(@geo.longitude).to eq(-99.877)
    end
  end

  context "When testing if the request returns expected event information for the given place_id" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      @result = client.get_astro_events(object: :moon, place_id: 3, start_date: "2020-03-05")
      @first_result = @result[0].objects[0].days[0].events[0]
      @second_result = @result[0].objects[0].days[0].events[1]
    end

    it "returns the expected type for the first and second event" do
      expect(@first_result.type).to eq("set")
      expect(@second_result.type).to eq("rise")
    end

    it "returns the expected azimuth for the first and second event" do
      expect(@first_result.azimuth).to eq(294.4)
      expect(@second_result.azimuth).to eq(66.0)
    end
  end

  context "When testing if requesting current event returns a result" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      @result = client.get_astro_events(object: :moon, place_id: 3, start_date: "2020-03-05", utctime: true, isotime: true, types: :current)
      @current = @result[0].objects[0].current
    end

    it "returns a utctime and isotime" do
      expect(@current.utctime).to be_truthy
      expect(@current.isotime).to be_truthy
    end

    it "returns the azimuth, altitude, distance, illuminated and posangle" do
      expect(@current.azimuth).to be_truthy
      expect(@current.altitude).to be_truthy
      expect(@current.distance).to be_truthy
      expect(@current.illuminated).to be_truthy
      expect(@current.posangle).to be_truthy
    end

    it "returns the moonphase" do
      expect(@current.moonphase).to be_truthy
    end
  end
end
