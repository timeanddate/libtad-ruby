module LibTAD
  module TADTime
    # DST information about a region.
    class DSTEntry
      # @return [::LibTAD::Places::Region]
      # The geographical region where this information is valid.
      # Contains country, a textual description of the region and the name of the biggest place.
      attr_reader :region

      # @return [::LibTAD::TADTime::TADTimeZone]
      # Information about the standard time zone. This element is always returned.
      attr_reader :stdtimezone

      # @return [::LibTAD::TADTime::TADTimeZone]
      # Information about the daylight savings time zone. Suppressed, if there are no DST changes in the
      # queried year. Please note that if the region is on daylight savings time for the whole year, this information will be returned
      # the stdtimezone element. Additionally, the special element will be set to allyear.
      attr_reader :dsttimezone

      # @return [DstEntrySpecial]
      # Indicates if the region does not observe DST at all, or is on DST all year long.
      attr_reader :special

      # @return [String]
      # Starting date of daylight savings time. Suppressed, if there are no DST changes in the queried year.
      attr_reader :dststart

      # @return [String]
      # Ending date of daylight savings time. Suppressed, if there are no DST changes in the queried year.
      attr_reader :dstend

      # @return [Array<::LibTAD::TADTime::TimeChange]
      # Time changes (daylight savings time). Only present if requested and information is available.
      attr_reader :timechanges

      def initialize(hash)
        @region = ::LibTAD::Places::Region.new hash['region'] unless !hash.key?('region')
        @stdtimezone = ::LibTAD::TADTime::TADTimeZone.new hash['stdtimezone'] unless !hash.key?('stdtimezone')
        @dsttimezone = ::LibTAD::TADTime::TADTimeZone.new hash['dsttimezone'] unless !hash.key?('dsttimezone')
        @special = hash.dig('special', 'type')
        @dststart = hash.fetch('dststart', nil)
        @dstend = hash.fetch('dstend', nil)
        @timechanges = hash.fetch('timechanges', nil)
          &.map { |e| ::LibTAD::TADTime::TimeChange.new(e) }
      end
    end
  end
end
