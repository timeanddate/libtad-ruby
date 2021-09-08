module LibTAD
  module Astronomy
    # Information about an astronomy object.
    class AstronomyObjectDetails
      # @return [String]
      # Object name.
      attr_reader :name

      # @return [Array<AstronomyDay>]
      # Lists and wraps all requested days where events are happening.
      attr_reader :days

      # @return [AstronomyCurrent]
      # The current data for the object. Only if requested.
      attr_reader :current

      # @return [Array<AstronomyCurrent>]
      # The specific data for the object at isotime/utctime.
      attr_reader :results

      def initialize(hash)
        @name = hash.fetch('name', nil)
        @days = hash.fetch('days', nil)
          &.map { |e| AstronomyDay.new(e) }

        @current = AstronomyCurrent.new hash['current'] unless !hash.key?('current')
        @results = hash.fetch('results', nil)
          &.map { |e| AstronomyCurrent.new(e) }
      end
    end
  end
end
