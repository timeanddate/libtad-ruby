module LibTAD
  module Astronomy
    # Moon phase.
    class MoonPhase
      # @return [String]
      # Moonphase id.
      attr_reader :id

      # @return [String]
      # Moonphase description.
      def description
        case @id
        when 'newmoon'
          'New moon'
        when 'waxingcrescent'
          'Waxing crescent'
        when 'firstquarter'
          'Moon in first quarter'
        when 'waxinggibbous'
          'Waxing gibbous moon'
        when 'fullmoon'
          'Full moon'
        when 'waninggibbous'
          'Waning gibbous moon'
        when 'thirdquarter'
          'Moon in third quarter'
        when 'waningcrescent'
          'Waning crescent moon'
        end
      end

      def initialize(id)
        @id = id
      end
    end
  end
end
