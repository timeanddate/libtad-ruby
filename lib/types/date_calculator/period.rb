module LibTAD
  module DateCalculator
    # Calculated results for a requested period.
    class Period
      # @return [Integer]
      # Number of days calculated.
      attr_reader :includeddays

      # @return [Integer]
      # Number of calendar days in calculated period.
      attr_reader :calendardays

      # @return [Integer]
      # Number of days which was skipped in the calculated period.
      attr_reader :skippeddays

      # @return [::LibTAD::TADTime::TADTime]
      # The date the calculation started from.
      attr_reader :startdate

      # @return [::LibTAD::TADTime::TADTime]
      # The date the calculation ended on.
      attr_reader :enddate

      # @return [::LibTAD::DateCalculator::Weekdays]
      # The spread of excluded or included weekdays in includeddays.
      attr_reader :weekdays

      # @return [::LibTAD::DateCalculator::BusinessHoliday]
      # Holidays which occur in the requested period.
      attr_reader :holidays

      def initialize(hash)
        @includeddays = hash.fetch('includeddays', nil)
        @calendardays = hash.fetch('calendardays', nil)
        @skippeddays = hash.fetch('skippeddays', nil)
        @startdate = ::LibTAD::TADTime::TADTime.new hash['startdate'] unless !hash.key?('startdate')
        @enddate = ::LibTAD::TADTime::TADTime.new hash['enddate'] unless !hash.key?('enddate')
        @weekdays = ::LibTAD::DateCalculator::Weekdays.new hash['weekdays'] unless !hash.key?('weekdays')
        @holidays = ::LibTAD::DateCalculator::BusinessHoliday.new hash['holidays'] unless !hash.key?('holidays')
      end
    end
  end
end
