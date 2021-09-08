require 'date'

module LibTAD
  module TADTime
    # Date and time, split up into components.
    class TADDateTime
      # @return [Integer]
      # The year component of the timestamp.
      attr_reader :year

      # @return [Integer]
      # The month component of the timestamp.
      attr_reader :month

      # @return [Integer]
      # The day component of the timestamp.
      attr_reader :day

      # @return [Integer]
      # The hour component of the timestamp.
      attr_reader :hour

      # @return [Integer]
      # The minute component of the timestamp.
      attr_reader :minute

      # @return [Integer]
      # The second component of the timestamp.
      attr_reader :second

      def initialize(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil)
        @year = year
        @month = month
        @day = day
        @hour = hour
        @minute = minute
        @second = second
      end

      # @return [Boolean]
      # Compare equality to another instance.
      def ==(other)
        other.year == @year &&
        other.month == @month &&
        other.day == @day &&
        other.minute == @minute &&
        other.second == @second
      end

      # @return [::LibTAD::TADTime::TADDateTime]
      # Helper function for initializing from json.
      def from_json(hash)
        @year = hash&.fetch('year', nil)
        @month = hash&.fetch('month', nil)
        @day = hash&.fetch('day', nil)
        @hour = hash&.fetch('hour', nil)
        @minute = hash&.fetch('minute', nil)
        @second = hash&.fetch('second', nil)
        
        self
      end

      # @return [String]
      # Helper function for formatting as ISO 8601.
      def to_iso8601
        year = @year.to_s.rjust(4, '0')
        month = @month.to_s.rjust(2, '0')
        day = @day.to_s.rjust(2, '0')
        "#{year}-#{month}-#{day}"
      end

      # @return [::LibTAD::TADTime::TADDateTime]
      # Get the current time.
      def now
        dt = ::Time.now
        @year = dt.year
        @month = dt.month
        @day = dt.day
        @hour = dt.hour
        @minute = dt.min
        @second = dt.sec

        self
      end

      # @return [::DateTime]
      # Try converting to Time from the standard library.
      def to_std!
        ::Time.new(@year, @month, @day, @hour, @minute, @second)
      end
    end
  end
end
