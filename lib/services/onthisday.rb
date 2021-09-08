module LibTAD
  class Client
    # On This Day API.
    module OnThisDayService
      # @return [Array<::LibTAD::OnThisDay::Event>, Array<::LibTAD::OnThisDay::Person>, Array<::LibTAD::OnThisDay::Person>]
      # @param month [Integer] The month for which the events should be retrieved. Defaults to current month.
      # @param day [Integer] The day for which the events should be retrieved. Defaults to current day.
      # @param lang [String or Array<String>] Specify the ISO639 Language Code or a list of codes for the texts.
      # @param types [Symbol or Array<Symbol>] Specify an event type or a list of event types to filter by.
      # @see ::LibTAD::OnThisDay::EVENT_TYPE
      #
      # The On This Day service can be used to retrieve events, births and deaths for a specific date.
      def get_events_on_this_day(month: nil, day: nil, lang: nil, types: nil)
        args = {
          month: month,
          day: day,
          lang: lang,
          types: (types unless ![*types].all? { |e| ::LibTAD::OnThisDay::EVENT_TYPE.include?(e) }),
        }.compact

        response = get('onthisday', args)
        events = response.fetch('events', [])
        births = response.fetch('births', [])
        deaths = response.fetch('deaths', [])

        events = events.collect do |e|
          ::LibTAD::OnThisDay::Event.new(e)
        end

        births = births.collect do |e|
          ::LibTAD::OnThisDay::Person.new(e)
        end

        deaths = deaths.collect do |e|
          ::LibTAD::OnThisDay::Person.new(e)
        end

        return events, births, deaths
      end
    end
  end
end
