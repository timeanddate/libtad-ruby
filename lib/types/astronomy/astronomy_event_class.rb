module LibTAD
  module Astronomy
    # All valid astronomy event classes
    ASTRONOMY_EVENT_CLASS = [
      # Combination of all known classes.
      :all,

      # The current phase for the place requested. Additional attributes for illumination (moon), azimuth, distance. 
      :current,

      # Day length. Day length is not reported as an event, but as a separate attribute.
      :daylength,

      # Meridian (Noon, highest point) and Anti-Meridian (lowest point) events.
      :meridian,

      # Moon phase events. Additionally to the phase events (only occurring on four days per lunar month),
      # an additional attribute for the current moon phase is reported for every day.
      :phase,
  
      # Set and rise events. Event times take atmospheric refraction into account.
      :setrise,

      # Combination of all 3 twilight classes.
      :twilight,

      # Civil twilight (-6°).
      :twilight6,

      # Nautical twilight (-12°).
      :twilight12,

      # Astronomical twilight (-18°).
      :twilight18
    ].freeze
  end
end
