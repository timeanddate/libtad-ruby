module LibTAD
  module OnThisDay
    # All valid event types.
    EVENT_TYPE = [
      # A historical event.
      :events,

      # Birth of a historical person.
      :births,

      # Death of a historical person.
      :deaths
    ].freeze
  end
end
