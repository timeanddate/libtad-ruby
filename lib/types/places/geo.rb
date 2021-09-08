module LibTAD
  module Places
    # Geographical information about a location.
    class Geo
      # @return [String]
      # The name of the location.
      attr_reader :name

      # @return [String]
      # The state of the location within the country (only if applicable).
      attr_reader :state
      
      # @return [Country]
      # Country of the location.
      attr_reader :country

      # @return [Float]
      # Geographical latitude of the location.
      attr_reader :latitude

      # @return [Float]
      # Geographical longitude of the location.
      attr_reader :longitude

      def initialize(hash)
        @name = hash.fetch('name', nil)
        @state = hash.fetch('state', nil)
        @country = Country.new hash['country'] unless !hash.key?('country')
        @latitude = hash.fetch('latitude', nil)
        @longitude = hash.fetch('longitude', nil)
      end
    end
  end
end
