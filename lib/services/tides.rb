module LibTAD
  class Client
    # Tides API.
    module TidesService
      # @return [Array<::LibTAD::Tides::Station>]
      # @param placeid [String] Specify the ID or a list of ID's for a location which you would like to get tidal data for.
      # @param onlyhighlow [Boolean] Whether to return every point per interval, or just the highest and lowest points.
      # @param start_date [String] Start of the requested time interval.
      # @param end_date [String] End of the requested time interval.
      # @param radius [Float] Search for tidal stations within the radius from the requested place.
      # @param subordinate [Boolean] Whether or not to resolve subordinate or just reference stations.
      # @param interval [Integer] How many minutes between each data point. Supported values: 5 min, 15 min, 30 min, 60 min.
      # @param localtime [Boolean] Whether input and output timestamps should be resolved to local time or not.
      #
      # The Tides service can be used to retrieve predicted tidal data over a given time interval for one or multiple places.
      def get_tidal_data(
        placeid:,
        onlyhighlow: nil,
        start_date: nil,
        end_date: nil,
        radius: nil,
        subordinate: nil,
        interval: nil,
        localtime: nil
      )
        args = {
          placeid: placeid,
          onlyhighlow: onlyhighlow,
          startdt: start_date,
          enddt: end_date,
          radius: radius,
          subordinate: subordinate,
          interval: interval,
          localtime: localtime
        }.compact

        response = get('tides', args)
        stations = response.fetch('stations', [])

        return stations.collect do |e|
          ::LibTAD::Tides::Station.new(e)
        end
      end
    end
  end
end
