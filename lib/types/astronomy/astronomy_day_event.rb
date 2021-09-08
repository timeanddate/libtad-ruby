module LibTAD
  module Astronomy
    # Information about an astronomical event at a specific day.
    class AstronomyDayEvent
      # @return [String]
      # Indicates the type of the event.
      attr_reader :type

      # @return [Integer]
      # Hour at which the event is happening (local time).
      attr_reader :hour

      # @return [Integer]
      # Minute at which the event is happening (local time).
      attr_reader :minute

      # @return [Integer]
      # Second at which the event is happening (local time).
      attr_reader :second

      # @return [String]
      # Local time at which the event is happening in ISO 8601 format (including UTC offset).
      # Only returned if requested by specifying the parameter isotime.
      #
      # Example: 2012-04-17T00:57:42+02:00
      attr_reader :isotime

      # @return [String]
      # UTC time at which the event is happening in ISO 8601 format.
      # Only returned if requested by specifying the parameter utctime.
      #
      # Example: 2012-04-16T22:57:42
      attr_reader :utctime

      # @return [Float] (degrees)
      # Altitude of the center of the queried astronomical object above an ideal horizon.
      # Only for meridian type events.
      attr_reader :altitude

      # @return [Float] (degrees)
      # Horizontal direction of the astronomical object at set/rise time (referring to true north).
      # North is 0 degrees, east is 90 degrees, south is 180 degrees and west is 270 degrees.
      # Only for rise and set type events.
      attr_reader :azimuth

      # @return [Float] (km)
      # Distance of the earth's center to the center of the queried astronomical object in kilometers.
      # Only for meridian type events.
      attr_reader :distance

      # @return [Float] (percent)
      # The fraction of the Moon's surface illuminated by the Sun's rays as seen from the selected location.
      # Only for the moon for meridian type events.
      attr_reader :illuminated

      # @return [Float] (degrees)
      # The counterclockwise angle of the midpoint of the Moon's bright limb as seen from the selected location.
      # Only for the moon for meridian type events.
      attr_reader :posangle

      def initialize(hash)
        @type = hash.fetch('type', nil)
        @hour = hash.fetch('hour', nil)
        @min = hash.fetch('min', nil)
        @sec = hash.fetch('sec', nil)
        @isotime = hash.fetch('isotime', nil)
        @utctime = hash.fetch('utctime', nil)
        @altitude = hash.fetch('altitude', nil)
        @azimuth = hash.fetch('azimuth', nil)
        @distance = hash.fetch('distance', nil)
        @illuminated = hash.fetch('illuminated', nil)
        @posangle = hash.fetch('posangle', nil)
      end
    end
  end
end
