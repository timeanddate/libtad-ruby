module LibTAD
  module DateCalculator
    # The spread of excluded or included weekdays.
    class Weekdays
      # @return [String]
      # Specifies whether or not the weekdays counted were part of an included or excluded filter.
      attr_reader :type

      # @return [Integer]
      # How many days in total have been counted.
      attr_reader :count

      # @return [Integer]
      # Count for Mondays.
      attr_reader :mon

      # @return [Integer]
      # Count for Tuesdays.
      attr_reader :tue

      # @return [Integer]
      # Count for Wednesdays.
      attr_reader :wed

      # @return [Integer]
      # Count for Thursdays.
      attr_reader :thu

      # @return [Integer]
      # Count for Fridays.
      attr_reader :fri

      # @return [Integer]
      # Count for Saturdays.
      attr_reader :sat

      # @return [Integer]
      # Count for Sundays.
      attr_reader :sun

      def initialize(hash)
        @type = hash.fetch('type', nil)
        @count = hash.fetch('count', nil)
        @mon = hash.fetch('mon', nil)
        @tue = hash.fetch('tue', nil)
        @wed = hash.fetch('wed', nil)
        @thu = hash.fetch('thu', nil)
        @fri = hash.fetch('fri', nil)
        @sat = hash.fetch('sat', nil)
        @sun = hash.fetch('sun', nil)
      end
    end
  end
end
