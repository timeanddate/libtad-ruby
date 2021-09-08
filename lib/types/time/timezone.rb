module LibTAD
  module TADTime
    # Timezone information.
    class TADTimeZone
      # @return [String]
      # The time zone offset (from UTC) in string representation.
      # 
      # Example: +11:00
      attr_reader :offset

      # @return [String]
      # Abbreviated time zone name.
      #
      # Example: LHDT
      attr_reader :zoneabb

      # @return [String]
      # Full time zone name.
      #
      # Example: Lord Howe Daylight Time
      attr_reader :zonename

      # @return [Integer]
      # Basic time zone offset (without DST) in seconds.
      #
      # Example: 37800
      attr_reader :zoneoffset

      # @return [Integer]
      # DST component of time zone offset in seconds.
      #
      # Example: 1800
      attr_reader :zonedst

      # @return [Integer]
      # Total offset from UTC in seconds.
      #
      #Example: 39600
      attr_reader :zonetotaloffset

      def initialize(hash)
        @offset = hash.fetch('offset', nil)
        @zoneabb = hash.fetch('zoneabb', nil)
        @zonename = hash.fetch('zonename', nil)
        @zoneoffset = hash.fetch('zoneoffset', nil)
        @zonedst = hash.fetch('zonedst', nil)
        @zonetotaloffset = hash.fetch('zonetotaloffset', nil)
      end
    end
  end
end
