
module LibTAD
  module Tides
    # Information about the tide at a specific point in time.
    class Tide
      # @return [::LibTAD::TADTime::TADTime]
      # Date/time of the specific tidal data point.
      attr_reader :time

      # @return [Float]
      # The elevation of tidal water above or below mean sea level.
      attr_reader :amplitude

      # @return [TidalPhase]
      # The current tidal phase.
      attr_reader :phase
 
      def initialize(hash)
        @time = ::LibTAD::TADTime::TADTime.new hash.fetch('time', nil)
        @amplitude = hash.fetch('amplitude', nil)
        @phase = hash.fetch('phase', nil)
      end
    end
  end
end
