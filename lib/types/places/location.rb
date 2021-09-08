module LibTAD
  module Places
    # Information about a location.
    class Location
      # @return [String]
      # The id of the location.
      attr_reader :id

      # @return [String]
      # The part of the queried placeid that this location matches.
      attr_reader :matchparam

      # @return [Geo]
      # Geographical information about the location.
      attr_reader :geo

      # @return [::LibTAD::TADTime::TADTime]
      # Time information. Only present if requested.
      attr_reader :time

      # @return [Array<::LibTAD::TADTime::TimeChange>]
      # Time changes (daylight savings time). Only present if requested and information is available.
      attr_reader :timechanges

      # @return [Array<::LibTAD::Astronomy::AstronomyObject>]
      # Astronomical information – sunrise and sunset times. Only for the timeservice and if requested.
      attr_reader :objects

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @matchparam = hash.fetch('matchparam', nil)
        @geo = Geo.new hash['geo'] unless !hash.key?('geo')
        @time = ::LibTAD::TADTime::TADTime.new hash['time'] unless !hash.key?('time')
        @timechanges = hash.fetch('timechanges', nil)
          &.map { |e| ::LibTAD::TADTime::TimeChange.new(e) }

        @objects = hash.fetch('astronomy', nil)
          &.fetch('objects', nil)
          &.map { |e| ::LibTAD::Astronomy::AstronomyObject.new(e) }
      end
    end
  end
end
