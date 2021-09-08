require 'date'

module LibTAD
  class Client
    # Holidays API.
    module HolidaysService
      # @return [Array<::LibTAD::Holidays::Holiday>]
      # @param country [String] Specify the ISO3166-1-alpha-2 Country Code for which you would like to retrieve the list of holidays.
      # @param year [Integer] The year for which the holidays should be retrieved. Defaults to current year.
      # @param lang [String or Array<String>] Specify the ISO639 Language Code or a list of codes for the texts.
      # @param types [Symbol or Array<Symbol>] Specify a holiday type or a list of holiday types to filter by.
      # @param timezone [Boolean] Adds time zone information under the time object.
      # @see ::LibTAD::Holidays::HOLIDAY_TYPE
      #
      # The Holidays service can be used to retrieve the list of holidays for a country.
      def get_holidays(country:, year: nil, lang: nil, types: nil, timezone: nil)
        args = {
          country: country,
          lang: lang,
          types: (types unless ![*types].all? { |e| ::LibTAD::Holidays::HOLIDAY_TYPE.include?(e) }),
          year: if year.nil? then ::Time.now.year else year end,
          tz: timezone
        }.compact

        response = get('holidays', args)
        holidays = response.fetch('holidays', [])

        holidays.collect do |e|
          ::LibTAD::Holidays::Holiday.new(e)
        end
      end
    end
  end
end
