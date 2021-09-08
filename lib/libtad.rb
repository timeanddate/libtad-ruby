require 'services/astronomy'
require 'services/date_calculator'
require 'services/holidays'
require 'services/onthisday'
require 'services/places'
require 'services/tides'
require 'services/time'

require 'types/astronomy/astronomy_current'
require 'types/astronomy/astronomy_day'
require 'types/astronomy/astronomy_day_event'
require 'types/astronomy/astronomy_event'
require 'types/astronomy/astronomy_event_class'
require 'types/astronomy/astronomy_location'
require 'types/astronomy/astronomy_object'
require 'types/astronomy/astronomy_object_details'
require 'types/astronomy/astronomy_object_type'
require 'types/astronomy/moonphase'

require 'types/date_calculator/business_days_filter'
require 'types/date_calculator/business_holiday'
require 'types/date_calculator/period'
require 'types/date_calculator/weekdays'

require 'types/holidays/holiday'
require 'types/holidays/holiday_state'
require 'types/holidays/holiday_type'

require 'types/onthisday/event'
require 'types/onthisday/event_type'
require 'types/onthisday/name'
require 'types/onthisday/person'

require 'types/places/country'
require 'types/places/geo'
require 'types/places/location'
require 'types/places/location_ref'
require 'types/places/place'
require 'types/places/region'

require 'types/tides/station'
require 'types/tides/station_info'
require 'types/tides/tide'

require 'types/time/datetime'
require 'types/time/dst_entry'
require 'types/time/time'
require 'types/time/time_change'
require 'types/time/timezone'

require 'base64'
require 'json'
require 'net/http'
require 'openssl'

module LibTAD
  # Main endpoint for accessing the Time and Date APIs.
  class Client

    include LibTAD::Client::AstronomyService
    include LibTAD::Client::DateCalculatorService
    include LibTAD::Client::HolidaysService
    include LibTAD::Client::OnThisDayService
    include LibTAD::Client::PlacesService
    include LibTAD::Client::TidesService
    include LibTAD::Client::TimeService

    # The endpoint the client connects to.
    ENDPOINT = 'https://api.xmltime.com/'.freeze

    # Client user agent.
    USER_AGENT = 'libtad-ruby-0.1.0'.freeze

    # API version.
    VERSION = 3.freeze

    def initialize(access_key:, secret_key:)
      @access_key = access_key
      @secret_key = secret_key
    end

    private

    def authenticate(service, args)
      timestamp = ::Time.now.utc.strftime('%FT%T')
      message = @access_key + service + timestamp

      hmac = OpenSSL::HMAC.digest('sha1', @secret_key, message)
      signature = Base64.encode64(hmac).chomp

      args[:accesskey] = @access_key
      args[:signature] = signature
      args[:timestamp] = timestamp

      args
    end

    def get(service, args)
      args = args.transform_values! do |e|
        if [true, false].include?(e)
          e && 1 || 0
        else
          e
        end
      end

      args[:version] = VERSION
      args = authenticate(service, args)

      uri = URI(ENDPOINT + service)
      uri.query = URI.encode_www_form(args)

      request = Net::HTTP::Get.new(uri)
      request["User-Agent"] = USER_AGENT

      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => (uri.scheme == 'https')) {|http|
        http.request(request)
      }

      res = JSON.parse(res.body)

      if (error = res.fetch('errors', nil))
        raise Exception.new error
      else
        res
      end
    end
  end
end
