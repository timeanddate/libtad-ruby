module LibTAD
  module OnThisDay
    # A full name.
    class Name
      # @return [String]
      # First name.
      attr_reader :first

      # @return [String]
      # Middle name.
      attr_reader :middle

      # @return [String]
      # Last name.
      attr_reader :last

      def initialize(hash)
        @first = hash.fetch('first', nil)
        @middle = hash.fetch('middle', nil)
        @last = hash.fetch('last', nil)
      end
    end
  end
end
