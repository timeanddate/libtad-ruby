require 'libtad'

RSpec.describe LibTAD::Client do
  before do
    access_key = ENV["ACCESS_KEY"]
    secret_key = ENV['SECRET_KEY']

    @client = LibTAD::Client.new(access_key: access_key, secret_key: secret_key)
  end

  context "When requesting the current time for a numeric id" do
    before do
      @results = @client.get_current_time(place_id: 179)
      @first_result = @results[0]
    end

    it "returns the expected id" do
      expect(@first_result.id).to eq("179")
    end
  end

  context "When requesting the current time for a pair of coordinates" do
    before do
      @results = @client.get_current_time(place_id: "+59.914+10.752")
      @first_result = @results[0]
    end

    it "returns the expected location" do
      expect(@first_result.geo.name).to eq("Oslo")
    end
  end

  context "When requesting the current time with a textual id" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo")
      @first_result = @results[0]
    end

    it "returns the expected id" do
      expect(@first_result.id).to eq("187")
    end
  end

  context "When requesting the current time with time changes" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", time_changes: true)
    end

    it "returns time change information" do
      expect(@results.all? { |e| e.timechanges.nil? }).to be false
    end
  end

  context "When requesting the current time without time changes" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", time_changes: false)
    end

    it "does not return time change information" do
      expect(@results.all? { |e| e.timechanges.nil? }).to be true
    end
  end

  context "When requesting the current time with coordinates" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", geo: true)
    end

    it "returns coordinates" do
      expect(@results.all? { |e| e.geo.latitude.nil? || e.geo.longitude.nil? }).to be false
    end
  end

  context "When requesting the current time without coordinates" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", geo: false)
    end

    it "returns coordinates" do
      expect(@results.all? { |e| e.geo.latitude.nil? || e.geo.longitude.nil? }).to be true
    end
  end

  context "When requesting the current time with information about sunrise and sunset" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", sun: true)
    end

    it "returns sunrise and sunset information" do
      expect(@results.all? { |e| e.objects.nil? || e.objects.nil? }).to be false
    end
  end

  context "When requesting the current time without information about sunrise and sunset" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", sun: false)
    end

    it "does not return sunrise and sunset information" do
      expect(@results.all? { |e| e.objects.nil? || e.objects.nil? }).to be true
    end
  end

  context "When requesting the current time with time zone information" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", timezone: true)
    end

    it "returns time zone information" do
      expect(@results.all? { |e| e.time.timezone.nil? || e.time.timezone.nil? }).to be false
    end
  end

  context "When requesting the current time without time zone information" do
    before do
      @results = @client.get_current_time(place_id: "norway/oslo", timezone: false)
    end

    it "does not return time zone information" do
      expect(@results.all? { |e| e.time.timezone.nil? || e.time.timezone.nil? }).to be true
    end
  end
end
