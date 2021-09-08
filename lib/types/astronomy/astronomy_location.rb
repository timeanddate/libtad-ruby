module LibTAD
  module Astronomy
    # Information about location and astronomical objects requested.
    class AstronomyLocation
      # @return [String]
      # The id of the location.
      attr_reader :id

      # @return [String]
      # The part of the queried placeid that this location matches.
      attr_reader :matchparam

      # @return [GeoType]
      # Geographical information about the location.
      attr_reader :geo

      # @return [Array<AstronomyObjectDetails>]
      # Requested astronomical information.
      attr_reader :objects

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @matchparam = hash.fetch('matchparam', nil)
        @geo = ::LibTAD::Places::Geo.new hash.fetch('geo', nil)
        @objects = hash.fetch('astronomy', nil)
          &.fetch('objects', nil)
          &.map { |e| AstronomyObjectDetails.new(e) }
      end
    end
  end
end
