module LibTAD
  module Astronomy
    # Information about an astronomy object for a specific day.
    class AstronomyDay
      # @return [String]
      # Date for the current information.
      attr_reader :date

      # @return [String]
      # Length of this day (time between sunrise and sunset). If the sun is not up on this day, 00:00:00 will reported.
      # If the sun does not set on this day, the value will read 24:00:00.
      # Attribute only applies for the sun object and if requested.
      attr_reader :daylength

      # @return [String]
      # Moon phase for the day. Only if requested.
      attr_reader :moonphase

      # @return [Array<AstronomyDayEvent>]
      # Lists all events during the day.
      attr_reader :events

      def initialize(hash)
        @date = hash.fetch('date', nil)
        @daylength = hash.fetch('daylength', nil)
        @moonphase = hash.fetch('moonphase', nil)
        @events = hash.fetch('events', nil)
          &.map { |e| AstronomyDayEvent.new(e) }
      end
    end
  end
end
