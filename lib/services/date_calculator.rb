module LibTAD
  class Client
    # Date Calculator API.
    module DateCalculatorService
      # @return [::LibTAD::Places::Geo, Array<::LibTAD::DateCalculator::Period>]
      # @param place_id [String] Specify the ID of the location you would like to calculate the business date.
      #   The ID is used to find what holidays are applicable for the given place so the calculation can exclude or include those results.
      # @param country [String] Specify the country for which you would like to calculate the business date.
      # @param state [String] Specify the state in the given country you want to calculate the business date.
      # @param start_date [::LibTAD::TADTime::TADDateTime or String] Specify the start date. Takes a TADDateTime object or a ISO 8601 date string.
      # @param days [Integer] Specify an amount or a list of amounts of business days to count.
      # @param including [Boolean] Specify whether the result should be calculated by including instead of excluding the days.
      # @param filter [Symbol] Specify a type or a list of types to filter by.
      # @param repeat [Integer] Set how many times the calculation should be repeated.
      # @param lang [String] The preferred language for the texts.
      # @see ::LibTAD::DateCalculator::BUSINESS_DAYS_FILTER
      #
      # The Businessdate service can be used to find a business date from a specified number of days.
      # By default the result will be filtered on excluding weekends and public holidays, but you can specify a custom filter to modify this.
      #
      # Either place_id or country is required.
      def add_days(
        place_id: nil,
        country: nil,
        state: nil,
        start_date:,
        days:,
        including: nil,
        filter: nil,
        repeat: nil,
        lang: nil
      )
        args = {
          placeid: place_id,
          country: country,
          state: state,
          startdt: if start_date.methods.include?(:to_iso8601) then start_date.to_iso8601 else start_date end,
          days: days,
          include: including,
          filter: (filter unless ![*filter].all? { |e| ::LibTAD::DateCalculator::BUSINESS_DAYS_FILTER.include?(e) }),
          repeat: repeat,
          lang: lang
        }.compact

        call_business_date(args, 'add')
      end

      # @return [::LibTAD::Places::Geo, Array<::LibTAD::DateCalculator::Period>]
      # @param place_id [String] Specify the ID of the location you would like to calculate the business date.
      #   The ID is used to find what holidays are applicable for the given place so the calculation can exclude or include those results.
      # @param country [String] Specify the country for which you would like to calculate the business date.
      # @param state [String] Specify the state in the given country you want to calculate the business date.
      # @param start_date [::LibTAD::TADTime::TADDateTime or String] Specify the start date. Takes a TADDateTime object or a ISO 8601 date string.
      # @param days [Integer] Specify an amount or a list of amounts of business days to count.
      # @param including [Boolean] Specify whether the result should be calculated by including instead of excluding the days.
      # @param filter [Symbol] Specify a type or a list of types to filter by.
      # @param repeat [Integer] Set how many times the calculation should be repeated.
      # @param lang [String] The preferred language for the texts.
      # @see ::LibTAD::DateCalculator::BUSINESS_DAYS_FILTER
      #
      # The Businessdate service can be used to find a business date from a specified number of days.
      # By default the result will be filtered on excluding weekends and public holidays, but you can specify a custom filter to modify this.
      #
      # Either place_id or country is required.
      def subtract_days(
        place_id: nil,
        country: nil,
        state: nil,
        start_date:,
        days:,
        including: nil,
        filter: nil,
        repeat: nil,
        lang: nil
      )
        args = {
          placeid: place_id,
          country: country,
          state: state,
          startdt: if start_date.methods.include?(:to_iso8601) then start_date.to_iso8601 else start_date end,
          days: days,
          include: including,
          filter: (filter unless ![*filter].all? { |e| ::LibTAD::DateCalculator::BUSINESS_DAYS_FILTER.include?(e) }),
          repeat: repeat,
          lang: lang
        }.compact

        call_business_date(args, 'subtract')
      end

      # @return [::LibTAD::Places::Geo, ::LibTAD::DateCalculator::Period]
      # @param place_id [String] Specify the ID of the location you would like to calculate the business duration.
      #   The ID is used to find what holidays are applicable for the given place so the calculation can exclude or include those results.
      # @param country [String] Specify the country for which you would like to calculate the business date.
      # @param state [String] Specify the state in the given country you want to calculate the business date.
      # @param start_date [::LibTAD::TADTime::TADDateTime or String] Specify the start date. Takes a TADDateTime object or a ISO 8601 date string.
      # @param end_date [::LibTAD::TADTime::TADDateTime or String] Specify the end date. Takes a TADDateTime object or a ISO 8601 date string.
      # @param including [Boolean] Specify whether the result should be calculated by including instead of excluding the days.
      # @param filter [Symbol] Specify a type or a list of types to filter by.
      # @param include_last_date [Boolean] Whether or not the last date should be counted in the result.
      # @param lang [String] The preferred language for the texts.
      # @see ::LibTAD::DateCalculator::BUSINESS_DAYS_FILTER
      #
      # The Businessduration service can be used to calculate the number of business days between a specified start date and end date.
      #
      # When you query the Businessduration service with a placeid or a country, a start date and an end date the service will return the number
      # of business days in that date range by excluding public holidays and weekends. Furthermore, you can apply additional filters
      # such as individual days and whether or not the calculation should include the filter result or exclude it.
      #
      # Either place_id or country is required.
      def get_duration(
        place_id: nil,
        country: nil,
        state: nil,
        start_date:,
        end_date:,
        including: nil,
        filter: nil,
        include_last_date: nil,
        lang: nil
      )
        args = {
          placeid: place_id,
          country: country,
          state: state,
          startdt: if start_date.methods.include?(:to_iso8601) then start_date.to_iso8601 else start_date end,
          enddt: if end_date.methods.include?(:to_iso8601) then end_date.to_iso8601 else end_date end,
          include: including,
          filter: (filter unless ![*filter].all? { |e| ::LibTAD::DateCalculator::BUSINESS_DAYS_FILTER.include?(e) }),
          includelastdate: include_last_date,
          lang: lang
        }.compact

        response = get('businessduration', args)
        geo = ::LibTAD::Places::Geo.new response['geo'] unless !response.key?('geo')
        period = ::LibTAD::DateCalculator::Period.new response['period'] unless !response.key?('period')

        return geo, period
      end

      private

      def call_business_date(args, operation)
        args[:op] = operation

        response = get('businessdate', args)
        geo = ::LibTAD::Places::Geo.new response['geo'] unless !response.key?('geo')
        period = response.fetch('periods', [])
          .map { |e| ::LibTAD::DateCalculator::Period.new(e) }

        return geo, period
      end
    end
  end
end
