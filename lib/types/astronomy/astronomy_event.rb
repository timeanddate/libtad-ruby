module LibTAD
  module Astronomy
    # Information about a sunrise/sunset event for a specific day.
    class AstronomyEvent
      # @return [String]
      # Indicates the type of the event.
      attr_reader :type

      # @return [Integer]
      # Hour at which the event is happening (local time).
      attr_reader :hour

      # @return [Integer]
      # Minute at which the event is happening (local time).
      attr_reader :minute

      def initialize(hash)
        @type = hash.fetch('type', nil)
        @hour = hash.fetch('hour', nil)
        @minute = hash.fetch('minute', nil)
      end
    end
  end
end
