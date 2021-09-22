module LibTAD
  module Tides
    # Information about a station.
    class StationInfo
      # @return [String]
      # Station name.
      attr_reader :name

      # @return [Float]
      # Latitude coordinates of the station.
      attr_reader :latitude

      # @return [Float]
      # Longitude coordinates of the station.
      attr_reader :longitude

      # @return [String]
      # Station type. Either reference or subordinate station.
      attr_reader :type

      # @return [Float]
      # Distance between request place and this station.
      attr_reader :distance
 
      def initialize(hash)
        @name = hash.fetch('name', nil)
        @latitude = hash.fetch('latitude', nil)
        @longitude = hash.fetch('longitude', nil)
        @type = hash.fetch('type', nil)
        @distance = hash.fetch('distance', nil)
      end
    end
  end
end
