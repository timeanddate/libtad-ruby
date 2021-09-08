module LibTAD
  module Places
    # Information about a location referenced by a region.
    class LocationRef
      # @return [String]
      # The ID of the location.
      attr_reader :id

      # @return [String]
      # The name of the location.
      attr_reader :name
      
      # @return [State]
      # The state of the location within the country (only if applicable).
      attr_reader :state

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @name = hash.fetch('name', nil)
        @state = hash.fetch('state', nil)
      end
    end
  end
end
