module LibTAD
  class Client
    # Tides API.
    module TidesService
      # @return [Array<::LibTAD::OnThisDay::Event>, Array<::LibTAD::OnThisDay::Person>, Array<::LibTAD::OnThisDay::Person>]
      # @param month [Integer] The month for which the events should be retrieved. Defaults to current month.
      # @param day [Integer] The day for which the events should be retrieved. Defaults to current day.
      # @param lang [String or Array<String>] Specify the ISO639 Language Code or a list of codes for the texts.
      # @param types [Symbol or Array<Symbol>] Specify an event type or a list of event types to filter by.
      # @see ::LibTAD::OnThisDay::EVENT_TYPE
      #
      # The On This Day service can be used to retrieve events, births and deaths for a specific date.
      def get_tidal_data(
        placeid:,
        onlyhighlow: nil,
        start_date: nil,
        end_date: nil,
        radius: nil,
        subordinate: nil,
        interval: nil,
        localtime: nil
      )
        args = {
          placeid: placeid,
          onlyhighlow: onlyhighlow,
          startdt: start_date,
          enddt: end_date,
          radius: radius,
          subordinate: subordinate,
          interval: interval,
          localtime: localtime
        }.compact

        response = get('tides', args)
        stations = response.fetch('stations', [])

        return stations.collect do |e|
          ::LibTAD::Tides::Station.new(e)
        end
      end
    end
  end
end
