
require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
    @all_results = client.get_places
    @result = @all_results[21]
  end

  context "When testing if the request returns expected geographical information for a specific place" do

    it "returns the expected id" do
      expect(@result.id).to eq(22)
    end

    it "returns the expected urlid" do
      expect(@result.urlid).to eq("new-zealand/auckland")
    end

    it "returns the expected name" do
      expect(@result.geo.name).to eq("Auckland")
    end

    it "returns the expected state" do
      expect(@result.geo.state).to eq("Auckland")
    end

    it "returns the expected country id and name" do
      expect(@result.geo.country.id).to eq("nz")
      expect(@result.geo.country.name).to eq("New Zealand")
    end

    it "returns the expected coordinates" do
      expect(@result.geo.latitude).to eq(-36.849)
      expect(@result.geo.longitude).to eq(174.762)
    end
  end

  context "When testing if the response returns geographical information for every place" do
    it "returns the expected id's" do
      @all_results.each.with_index(1) do |r, i|
        expect(r.id).to eq(i)
      end
    end

    it "returns a name" do
      @all_results.each do |r|
        expect(r.geo.name).to be_truthy
      end
    end

    it "returns a country id and name" do
      @all_results.each do |r|
        expect(r.geo.country.id).to be_truthy
        expect(r.geo.country.name).to be_truthy
      end
    end

    it "returns a pair of coordinates" do
      @all_results.each do |r|
        expect(r.geo.latitude).to be_truthy
        expect(r.geo.longitude).to be_truthy
      end
    end
  end

  context "When requesting a list of places without information about coordinates" do
    before do
      access_key = ENV["ACCESS_KEY"]
      secret_key = ENV['SECRET_KEY']

      client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
      all_results = client.get_places(geo: false)
      @result_woc = all_results[21]
    end

    it "returns the expected id" do
      expect(@result_woc.id).to eq(22)
    end

    it "returns the expected urlid" do
      expect(@result_woc.urlid).to eq("new-zealand/auckland")
    end

    it "returns the expected name" do
      expect(@result_woc.geo.name).to eq("Auckland")
    end

    it "returns the expected state" do
      expect(@result_woc.geo.state).to eq("Auckland")
    end

    it "returns the expected country id and name" do
      expect(@result_woc.geo.country.id).to eq("nz")
      expect(@result_woc.geo.country.name).to eq("New Zealand")
    end

    it "does not return a pair of coordinates" do
      expect(@result_woc.geo.latitude).to be_falsey
      expect(@result_woc.geo.longitude).to be_falsey
    end
  end
end

