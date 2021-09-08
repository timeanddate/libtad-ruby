module LibTAD
  module TADTime
    # Information about a time change.
    class TimeChange
      # @return [Integer]
      # New DST offset in seconds. Value will be null/empty if there is no DST for this location.
      attr_reader :newdst

      # @return [Integer]
      # New time zone offset to UTC in seconds if there is a time zone change for this place. Otherwise the value will be null/empty.
      # Time zones changes happen only very rarely, so the field will be null/empty on most occasions.
      attr_reader :newzone

      # @return [Integer]
      # New total offset to UTC in seconds.
      attr_reader :newoffset

      # @return [String]
      # Time stamp of transition in UTC time, formatted as ISO 8601 time.
      #
      # Example: 2011-03-27T01:00:00
      # @see https://dev-test.timeanddate.com/docs/external-references#ISO8601 ISO8601
      attr_reader :utctime

      # @return [String]
      # Local time before transition, formatted as ISO 8601 time.
      #
      # Example: 2011-03-27T02:00:00
      # @see https://dev-test.timeanddate.com/docs/external-references#ISO8601 ISO8601
      attr_reader :oldlocaltime

      # @return [String]
      # Local time after transition, formatted as ISO 8601 time.
      #
      # Example: 2011-03-27T03:00:00
      # @see https://dev-test.timeanddate.com/docs/external-references#ISO8601 ISO8601
      attr_reader :newlocaltime

      def initialize(hash)
        @newdst = hash.fetch('newdst', nil)
        @newzone = hash.fetch('newzone', nil)
        @newoffset = hash.fetch('newoffset', nil)
        @utctime = hash.fetch('utctime', nil)
        @oldlocaltime = hash.fetch('oldlocaltime', nil)
        @newlocaltime = hash.fetch('newlocaltime', nil)
      end
    end
  end
end
