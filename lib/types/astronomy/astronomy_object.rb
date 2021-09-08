module LibTAD
  module Astronomy
    # Astronomical information - sunrise and sunset times.
    class AstronomyObject
      # @return [String]
      # Object name. Currently, the sun is the only supported astronomical object.
      attr_reader :name

      # @return [Array<AstronomyEvent>]
      # Lists all sunrise/sunset events during the day.
      attr_reader :events

      # @return [String]
      # This element is only present if there are no astronomical events.
      # In this case it will indicate if the sun is up or down the whole day.
      attr_reader :special

      def initialize(hash)
        @name = hash.fetch('name', nil)
        @events = hash.fetch('events', nil)
          &.map { |e| AstronomyEvent.new(e) }

        @special = hash.dig('special', 'type')
      end
    end
  end
end
