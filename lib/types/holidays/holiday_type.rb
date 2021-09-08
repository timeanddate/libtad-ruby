module LibTAD
  module Holidays
    # All valid holiday types
    HOLIDAY_TYPE = [
      # Combinations of all known types (except fun).
      :all,

      # Default holiday set: federal, federallocal, obs1, weekday.
      :default,

      # Default set depending on country.
      # For most countries, this is the same as default. However,
      # for some countries it makes sense to add further types – this type 
      # accounts for this case. Currently this only affects the UK: 
      # local holidays are added as well. This is to include days that 
      # are only valid in one of countries – e.g. Jan 2 is a holiday only for Scotland.
      :countrydefault,

      # Important (obs1), common (obs2) and other observances (obs3).
      :obs,
      
      # All religious holidays: buddhism, christian, hebrew, hinduism, muslim, orthodox.
      :religious,

      # Some countries (e.g. Sweden) have days which are de facto treted as official holidays, even if there's no legal regulation.
      :defacto,

      # Federal/national holidays.
      :federal,

      # Common local holidays.
      :federallocal,

      # Flag days.
      :flagday,

      # Half day holidays (only afternoon off). These days can be half day holidays either by law, or being de facto half day holidays (e.g. Sweden).
      :halfday,

      # Local holidays.
      :local,

      # Local observances.
      :local2,

      # Important observances.
      :obs1,

      # Common observances.
      :obs2,

      # Other observances
      :obs3,

      # Optional holiday.
      # Employment and holiday laws in certain countries allow employees to choose a 
      # limited number of holidays from a list of holidays. Some employees may 
      # choose to take the day off on these day, however, most offices and businesses remain open.
      :optional,

      # Normal working days.
      # In some cases, working days are declared non-working days 
      # in order to form a longer period of consecutive non-working days.
      # In exchange, weekend days become normal working days.
      :weekday,

      # Buddhist holidays.
      :buddhism,

      # Christian holidays.
      :christian,

      # Hebrew holidays.
      :hebrew,

      # Hindu holidays.
      :hinduism,

      # Muslim holidays.
      :muslim,

      # Orthodox holidays.
      :orthodox,

      # Religious holidays, not covered by other types.
      :otherreligion,

      # Seasons (equinoxes and solstices).
      :seasons,

      # Sport events.
      :sport,

      # Time zone events – daylight savings time start and end.
      :tz,

      # United Nations days.
      :un,

      # Worldwide observances.
      :world,

      # Fun, Wacky and Trivial holidays.
      :fun,
    ].freeze
  end
end
