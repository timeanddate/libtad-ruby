require 'libtad'

RSpec.describe LibTAD::Client do
  context "When requesting astronomy positions for all objects" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
    end

    it "returns a result for every request, matching the object type" do
      ::LibTAD::Astronomy::ASTRONOMY_OBJECT_TYPE.each do |object|
        result = @client.get_astro_position(object: object, place_id: 3, interval: "2020-03-05")
        expect(result[0].objects[0].name).to eq(object.to_s)
      end
    end
  end

  context "When requesting astronomy positions for multiple intervals" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      intervals = (1...5).zip((5...9), (12...16)).map do |m, d, s|
        "2020-#{m.to_s.rjust(2, '0')}-#{d.to_s.rjust(2, '0')}T05:04:#{s.to_s.rjust(2, '0')}"
      end

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      result = client.get_astro_position(object: :moon, place_id: 3, interval: intervals)
      @results = result[0].objects[0].results
    end

    it "returns a list of 4 results" do
      expect(@results.length()).to eq(4)
    end
  end

  context "When requesting astronomy positions for a specific language" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      @result = client.get_astro_position(object: :sun, place_id: 187, interval: "2020-03-01", lang: "es")
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
      result = client.get_astro_position(object: :sun, place_id: 3, interval: "2020-03-15")
      @geo = result[0].geo
    end

    it "returns the expected name" do
      expect(@geo.name).to eq("Acapulco")
    end

    it "returns the expected state " do
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

  context "When testing if a request with and without localtime are equal" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      first_result = client.get_astro_position(object: :moon, place_id: 3, interval: "2020-03-05")
      second_result = client.get_astro_position(object: :moon, place_id: 3, interval: "2020-03-05", localtime: true)

      @first_object = first_result[0].objects[0].results[0]
      @second_object = second_result[0].objects[0].results[0]
    end

    it "returns inequal azimuths" do
      expect(@first_object.azimuth).not_to eq(@second_object.azimuth)
    end

    it "returns inequal altitudes" do
      expect(@first_object.altitude).not_to eq(@second_object.altitude)
    end

    it "returns inequal distance" do
      expect(@first_object.distance).not_to eq(@second_object.distance)
    end

    it "returns inequal illuminated value" do
      expect(@first_object.illuminated).not_to eq(@second_object.illuminated)
    end

    it "returns inequal posangle value" do
      expect(@first_object.posangle).not_to eq(@second_object.posangle)
    end
  end
end
