module LibTAD
  module DateCalculator
    # All valid business days filters.
    BUSINESS_DAYS_FILTER = [
      # Include or exclude Mondays.
      :mon,

      # Include or exclude Tuesdays.
      :tue,

      # Include or exclude Wednesdays.
      :wed,

      # Include or exclude Thursdays.
      :thu,

      # Include or exclude Fridays.
      :fri,

      # Include or exclude Saturdays.
      :sat,

      # Include or exclude Sundays.
      :sun,

      # Include or exclude weekends.
      :weekend,

      # Include or exclude holidays.
      :holidays,

      # Include or exclude weekends and holidays combined.
      :weekendholidays,

      # Include or exclude nothing.
      :none
    ].freeze
  end
end
