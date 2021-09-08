module LibTAD
  module Holidays
    # A holiday event in a specific state.
    class HolidayState
      # @return [String]
      # An ISO 3166-1 country or ISO 3166-2 country state code.
      # @see https://dev-test.timeanddate.com/docs/external-references#ISO3166 ISO3166
      attr_reader :iso

      # @return [Integer]
      # Unique id of the state/subdivision.
      attr_reader :id

      # @return [String]
      # Abbreviation of the state/subdivision.
      attr_reader :abbrev

      # @return [String]
      # Common name of the state/subdivision.
      attr_reader :name

      # @return [String]
      # Eventual exception if the holiday does not affect the whole state/subdivision.
      attr_reader :exception

      def initialize(hash)
        @iso = hash.fetch('iso', nil)
        @id = hash.fetch('id', nil)
        @abbrev = hash.fetch('abbrev', nil)
        @name = hash.fetch('name', nil)
        @exception = hash.fetch('exception', nil)
      end
    end
  end
end
