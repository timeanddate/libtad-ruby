module LibTAD
  module Tides
    # Predicted data for a given station.
    class Station
      # @return [StationInfo]
      # The source station for the predicted tidal data.
      attr_reader :source

      # @return [String]
      # The part of the queried placeid that this location matches.
      attr_reader :matchparam

      # @return [Array<Tide>]
      # Requested tidal information.
      attr_reader :result

 
      def initialize(hash)
        @source = StationInfo.new hash.fetch('source', nil)

        @matchparam = hash.fetch('matchparam', nil)
        @result = hash.fetch('result', nil)
          &.map { |e| Tide.new(e) }
      end
    end
  end
end
