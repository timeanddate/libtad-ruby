module LibTAD
  module Places
    # Information about a place.
    class Place
      # @return [String]
      # Numerical ID of the referenced place.
      attr_reader :id

      # @return [String]
      # Textual ID of the referenced place.
      attr_reader :urlid

      # @return [Geo]
      # Geographical information about the location.
      attr_reader :geo

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @urlid = hash.fetch('urlid', nil)
        @geo = Geo.new hash['geo'] unless !hash.key?('geo')
      end
    end
  end
end
