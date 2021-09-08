require 'date'

module LibTAD
  class Client
    # Astronomy API.
    module AstronomyService
      # @return [Array<::LibTAD::Astronomy::AstronomyLocation>]
      # @param object [Symbol] Specify an object type to retrieve information about.
      # @param place_id [String] Specify the ID or a list of IDs of the location(s) you would like to retrieve information for.
      # @param start_date [String] Specify the ISO 8601 date for the first date you are interested in. Defaults to current date.
      # @param end_date [String] The last date you are interested in. The service can be used to calculate data for a maximum of 31 days in a row. 
      #   If the end date is omitted, only one day is retrieved.
      # @param types [Symbol or Array<Symbol>] Specify an astronomical event class or a list of classes to filter by.
      # @param geo [Boolean] Return longitude and latitude for the geo object.
      # @param isotime [Boolean] Adds time stamps (local time) in ISO 8601 format to all events.
      # @param lang [String] Preferred language for texts.
      # @param radius [Integer] Search radius for translating coordinates to locations.
      # @param utctime [Boolean] Adds UTC time stamps in ISO 8601 format to all events.
      # @see ::LibTAD::Astronomy::ASTRONOMY_OBJECT_TYPE
      # @see ::LibTAD::Astronomy::ASTRONOMY_EVENT_CLASS
      #
      # The Astro Event service can be used retrieve the sunrise, sunset, moonrise, moonset, solar noon and twilight times for all
      # locations in our database. The service also returns the azimuth of the events, the altitude, and the distance to the sun for the noon event.
      def get_astro_events(
        object:,
        place_id:,
        start_date: nil,
        end_date: nil,
        types: nil,
        geo: nil,
        isotime: nil,
        lang: nil,
        radius: nil,
        utctime: nil
      )
        args = {
          object: (object unless !::LibTAD::Astronomy::ASTRONOMY_OBJECT_TYPE.include?(object)),
          placeid: place_id,
          startdt: if start_date.nil? then ::Time.now.strftime('%Y-%m-%d') else start_date end,
          enddt: end_date,
          types: (types unless ![*types].all? { |e| ::LibTAD::Astronomy::ASTRONOMY_EVENT_CLASS.include?(e) }),
          geo: geo,
          isotime: isotime,
          lang: lang,
          radius: radius,
          utctime: utctime
        }.compact

        response = get('astronomy', args)
        astroevents = response.fetch('locations', [])

        astroevents.collect do |e|
          ::LibTAD::Astronomy::AstronomyLocation.new(e)
        end
      end


      # @return [Array<::LibTAD::Astronomy::AstronomyLocation>]
      # @param object [Symbol] Specify an object type to retrieve information about.
      # @param place_id [String] Specify the ID of the location you would like to retrieve information for.
      # @param interval [String or Array<String>] Specify the point or a list of points in time you would like to calculate data for.
      # @param localtime [Boolean] Specify whether or not the intervals should be considered the local time for the place(s) or UTC time.
      # @param utctime [Boolean] Adds UTC time stamps in ISO 8601 format to all events.
      # @param isotime [Boolean] Adds time stamps (local time) in ISO 8601 format to all events.
      # @param lang [String] Preferred language for texts.
      # @param radius [Integer] Search radius for translating coordinates to locations.
      # @see ::LibTAD::Astronomy::ASTRONOMY_OBJECT_TYPE
      #
      # The Astro Position service can be used to retrieve the altitude, azimuth and distance to the Moon and the Sun for all locations in our database.
      # The service also returns the moon phase, the fraction of the Moon's illuminated side as well as the midpoint angle of the Moon's bright limb at any point in time.
      # Unlike the Astro Event service, the Astro Position service can be queried on a specific point in time, down to the second.
      def get_astro_position(
        object:,
        place_id:,
        interval:,
        localtime: nil,
        utctime: nil,
        isotime: nil,
        lang: nil,
        radius: nil
      )
        args = {
          object: (object unless !::LibTAD::Astronomy::ASTRONOMY_OBJECT_TYPE.include?(object)),
          placeid: place_id,
          interval: interval,
          localtime: localtime,
          utctime: utctime,
          isotime: isotime,
          lang: lang,
          radius: radius
        }.compact

        response = get('astrodata', args)
        astropositions = response.fetch('locations', [])

        astropositions.collect do |e|
          ::LibTAD::Astronomy::AstronomyLocation.new(e)
        end
      end
    end
  end
end
