module LibTAD
  module OnThisDay
    # A historical person.
    class Person
      # @return [Integer]
      # Identifier for the person.
      attr_reader :id

      # @return [::LibTAD::OnThisDay::Name]
      # Full name.
      attr_reader :name

      # @return [::LibTAD::TADTime::TADTime]
      # Date of birth.
      attr_reader :birthdate

      # @return [::LibTAD::TADTime::TADTime]
      # Date of death, if applicable.
      attr_reader :deathdate

      # @return [Array<String>]
      # Person categories.
      attr_reader :categories

      # @return [Array<String>]
      # The nationalities of the person
      attr_reader :nationalities

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @name = ::LibTAD::OnThisDay::Name.new hash.fetch('name', nil)
        @birthdate = ::LibTAD::TADTime::TADTime.new hash['birthdate'] unless !hash.key?('birthdate')
        @deathdate = ::LibTAD::TADTime::TADTime.new hash['deathdate'] unless !hash.key?('deathdate')
        @categories = hash.fetch('categories', nil)
        @nationalities = hash.fetch('nationalities', nil)
      end
    end
  end
end
