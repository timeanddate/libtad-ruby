module LibTAD
  module Places
    # Information about a country.
    class Country
      # @return [String]
      # The ISO 3166-1-alpha-2 country code.
      # @see https://dev-test.timeanddate.com/docs/external-references#ISO3166 ISO3166
      attr_reader :id

      # @return [String]
      # Full name of the country.
      attr_reader :name

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @name = hash.fetch('name', nil)
      end
    end
  end
end
