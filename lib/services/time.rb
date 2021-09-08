module LibTAD
  class Client
    # Time API.
    module TimeService
      # @return [Array<::LibTAD::Places::Location>]
      # @param place_id [String] Specify the ID or a list of the ID's for a location which you would like to get the current time from.
      # @param query [String] Query for a location by specifying the name.
      # @param qlimit [Integer] Maximum number of query results to be returned.
      # @param geo [Boolean] Return longitude and latitude for the geo object.
      # @param lang [String] The preferred language for the texts.
      # @param radius [Integer] Search radius for translating coordinates to locations.
      # @param sun [Boolean] Controls if the astronomy element with information about sunrise and sunset shall be added to the result.
      # @param time [Boolean] Adds current time under the location object.
      # @param time_changes [Boolean] Adds a list of thime changes during the year to the location object.
      # @param timezone [Boolean] Adds time zone information under the time object.
      #
      # The Time service can be used to retrieve the current time in one or more places.
      # Additionally, information about time zones and related changes and the time of sunrise and sunset can be queried.
      #
      # Either a place_id or a query is required.
      def get_current_time(
        place_id: nil,
        query: nil,
        qlimit: nil,
        geo: nil,
        lang: nil,
        radius: nil,
        sun: nil,
        time: nil,
        time_changes: nil,
        timezone: nil
      )
        args = {
          placeid: place_id,
          query: query,
          qlimit: qlimit,
          geo: geo,
          lang: lang,
          radius: radius,
          sun: sun,
          time: time,
          timechanges: time_changes,
          tz: timezone
        }.compact

        response = get('timeservice', args)
        locations = response.fetch('locations', [])

        locations.collect do |e|
          ::LibTAD::Places::Location.new(e)
        end
      end

      # @return [::LibTAD::TADTime::TADTime, Array<::LibTAD::Places::Locations>]
      # @param from_id [String] Specify the ID of the location for which the supplied time stamp corresponds.
      # @param to_id [String] Specify the ID or a list of ID's for the location(s) for which the time stamp should be converted.
      # @param iso [String] Time stamp in ISO8601 format.
      # @param datetime [::LibTAD::TADTime::TADDateTime] A date object.
      # @param lang [String] The preferred language for the texts.
      # @param radius [Integer] Search radius for translating coordinates to locations.
      # @param time_changes [Boolean] Add a list of time changes during the year to the location object.
      # @param timezone [Boolean] Add time zone information under the time object.
      #
      # The Converttime service can be used to convert any time from UTC or any of the supported locations to any other of the supported locations.
      # You have to specify a time stamp either in ISO8601 representation via the iso argument, or you have to specify the date via the datetime argument.
      # Skipped components will not yield an error message, but use a default value instead (which corresponds to 01.01.2001, 00:00:00).
      def convert_time(
        from_id:,
        to_id: nil,
        iso: nil,
        datetime: nil,
        lang: nil,
        radius: nil,
        time_changes: nil,
        timezone: nil
      )
        args = {
          fromid: from_id,
          toid: to_id,
          iso: iso,
          year: (datetime.year unless datetime.nil?),
          month: (datetime.month unless datetime.nil?),
          day: (datetime.day unless datetime.nil?),
          hour: (datetime.hour unless datetime.nil?),
          min: (datetime.minute unless datetime.nil?),
          sec: (datetime.second unless datetime.nil?),
          lang: lang,
          radius: radius,
          timechanges: time_changes,
          tz: timezone
        }.compact

        response = get('converttime', args)
        utc = ::LibTAD::TADTime::TADTime.new response.dig('utc', 'time') unless response.dig('utc', 'time').nil?
        locations = response.fetch('locations', [])
          .map { |e| ::LibTAD::Places::Location.new(e) }

        return utc, locations
      end

      # @return [Array<::LibTAD::DST::DSTEntry>]
      # @param year [Integer] The year you want to retrieve the information for. Defaults to current year.
      # @param country [String] Specify the country for which you want to retrieve information for. If unspecified, information for all countries will be returned.
      #   Specifying this parameter automatically sets the parameter onlydst to 0.
      # @param lang [String] The preferred language for the texts.
      # @param list_places [Boolean] For every time zone/country, list the individual places that belong to each record.
      # @param only_dst [Boolean] Return only countries which actually observe DST in the queried year. Other countries will be suppressed.
      # @param time_changes [Boolean] Add a list of time changes during the year to the dstentry object.
      #
      # The Dstlist service can be used to obtain data about time zones for all supported countries in our database.
      # This includes the start and end date of daylight savings time, and UTC offset for the time zones.
      #
      # The resulting data is aggregated on country and time zone level. By default, only information from countries which actually observe DST is
      # returned without listing the individually affected locations – see the parameters list_places and only_dst to change this behavior.
      def get_daylight_savings_time(
        year: nil,
        country: nil,
        lang: nil,
        list_places: nil,
        only_dst: nil,
        time_changes: nil
      )
        args = {
          year: year,
          country: country,
          lang: lang,
          listplaces: list_places,
          onlydst: only_dst,
          timechanges: time_changes
        }.compact

        response = get('dstlist', args)

        dstlist = response.fetch('dstlist', [])

        dstlist.collect do |e|
          ::LibTAD::TADTime::DSTEntry.new(e)
        end
      end
    end
  end
end

