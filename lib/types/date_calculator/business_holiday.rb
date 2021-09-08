module LibTAD
  module DateCalculator
    # A holiday event which occurs in a requested period.
    class BusinessHoliday
      # @return [String]
      # Either included or excluded, specifying whether or not the holidays
      # in the result array were included or excluded when queried.
      attr_reader :type

      # @return [Integer]
      # The number of holidays in the results.
      attr_reader :count

      # @return [Array<::LibTAD::Holiday::Holiday>]
      # Holidays which occur in the requested period.
      attr_reader :list

      def initialize(hash)
        @type = hash.fetch('type', nil)
        @count = hash.fetch('count', nil)
        @list = hash.fetch('list', nil)
          &.map { |e| ::LibTAD::Holidays::Holiday.new(e) }
      end
    end
  end
end
