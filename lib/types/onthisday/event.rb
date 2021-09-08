module LibTAD
  module OnThisDay
    # A historical event.
    class Event
      # @return [Integer]
      # Identifier for the event.
      attr_reader :id

      # @return [Hash<String, String>]
      # Hash of languages with corresponding event name.
      attr_reader :name

      # @return [::LibTAD::TADTime::TADTime]
      # Date of the event.
      attr_reader :date

      # @return [String]
      # Location of the event.
      attr_reader :location

      # @return [Array<String>]
      # Event categories.
      attr_reader :categories

      # @return [Array<::LibTAD::Places::Country>]
      # Related countries.
      attr_reader :countries

      # @return [Hash<String, String>]
      # Languages with corresponding event description.
      attr_reader :description

      def initialize(hash)
        @id = hash.fetch('id', nil)
        @name = hash.fetch('name', nil)
          &.map { |e| [ e['lang'], e['text'] ] }
          .to_h

        @date = ::LibTAD::TADTime::TADTime.new hash.fetch('date', nil)
        @location = hash.fetch('location', nil)
        @categories = hash.fetch('categories', nil)
        @countries = hash.fetch('countries', nil)
          &.map { |e| ::LibTAD::Places::Country.new(e) }

        @description = hash.fetch('description', nil)
          &.map { |e| [ e['lang'], e['text'] ] }
          .to_h
      end
    end
  end
end
