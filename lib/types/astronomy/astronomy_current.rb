module LibTAD
  module Astronomy
    # Current information about an astronomy object.
    class AstronomyCurrent
      # @return [String]
      # Local time stamp for the data in ISO 8601 format (including UTC offset).
      # Only returned if requested by specifying the parameter isotime.
      #
      # Example: 2012-04-17T00:57:42+02:00
      attr_reader :isotime

      # @return [String]
      # UTC time stamp for the data in ISO 8601 format.
      # Only returned if requested by specifying the parameter utctime.
      #
      # Example: 2012-04-16T22:57:42
      attr_reader :utctime

      # @return [Float]
      # Altitude of the center of the queried astronomical object above an ideal horizon.
      attr_reader :altitude

      # @return [Float] (degrees)
      # Horizontal direction of the astronomical object at set/rise time (referring to true north).
      # North is 0 degrees, east is 90 degrees, south is 180 degrees and west is 270 degrees.
      attr_reader :azimuth

      # @return [Float] (km)
      # Distance of the earth's center to the center of the queried astronomical object in kilometers.
      attr_reader :distance

      # @return [Float] (percent)
      # The fraction of the Moon's surface illuminated by the Sun's rays as seen from the selected location.
      # Only available for the moon object.
      attr_reader :illuminated

      # @return [Float] (degrees)
      # The counterclockwise angle of the midpoint of the Moon's bright limb as seen from the selected location.
      # Only available for the moon object.
      attr_reader :posangle

      # @return [MoonPhase]
      # The current phase of the moon. Only available for the moon object.
      attr_reader :moonphase

      def initialize(hash)
        @isotime = hash.fetch('isotime', nil)
        @utctime = hash.fetch('utctime', nil)
        @altitude = hash.fetch('altitude', nil)
        @azimuth = hash.fetch('azimuth', nil)
        @distance = hash.fetch('distance', nil)
        @illuminated = hash.fetch('illuminated', nil)
        @posangle = hash.fetch('posangle', nil)
        @moonphase = MoonPhase.new hash['moonphase'] unless !hash.key?('moonphase')
      end
    end
  end
end
