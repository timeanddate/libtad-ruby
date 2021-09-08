module LibTAD
  module Places
    # The geographical region. Contains country, a textual description of
    # the region and the name of the biggest place.
    class Region
      # @return [Country]
      # Country which the region belongs to.
      attr_reader :country

      # @return [String]
      # Textual description of a region.
      #
      # Example: All locations
      # Example: most of Newfoundland and Labrador
      # Example: some regions of Nunavut Territory; small region of Ontario
      attr_reader :desc

      # @return [String]
      # Name of the biggest city within the region.
      attr_reader :biggestplace

      # @return [Array<LocationRef>]
      # A list of all locations referenced by this region. Only returned if requested by specifying the parameter listplaces.
      attr_reader :locations

      def initialize(hash)
        @country = Country.new hash['country'] unless !hash.key?('country')
        @desc = hash.fetch('desc', nil)
        @biggestplace = hash.fetch('biggestplace', nil)
        @locations = hash.fetch('locations', nil)
          &.map { |e| LocationRef.new(e) }
      end
    end
  end
end
