module LibTAD
  module TADTime
    # Information about date, time and timezone.
    class TADTime
      # @return [String]
      # ISO representation of date and time, time zone included
      # (@see https://dev-test.timeanddate.com/docs/external-references#ISO8601 ISO8601)
      # if different from UTC. If time is not applicable, only the date is shown.
      #
      # Example: 2011-06-08T09:18:16+02:00
      # Example: 2011-06-08T07:18:16 (UTC time)
      # Example: 2011-06-08 (only date)
      attr_reader :iso

      # @return [DateTime]
      # Date and time, split up into components.
      attr_reader :datetime

      # @return [TimeZone]
      # Timezone information.
      attr_reader :timezone

      def initialize(hash)
        @iso = hash.fetch('iso', nil)
        @datetime = TADDateTime.new.from_json hash['datetime'] unless !hash.key?('datetime')
        @timezone = TADTimeZone.new hash['timezone'] unless !hash.key?('timezone')
      end
    end
  end
end
