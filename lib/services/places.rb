module LibTAD
  class Client
    # Places API.
    module PlacesService
      # @return [Array<::LibTAD::Places::Place>]
      # @param geo [Boolean] Return longitude or latitude for the geo object.
      # @param lang [Boolean] The preferred language for the texts.
      #
      # The Places service can be used to retrieve the list of supported places. The ids for the places are 
      # then used in the other services to indicate the location to be queried.
      def get_places(geo: nil, lang: nil)
        args = {
          geo: geo,
          lang: lang
        }.compact

        response = get('places', args)
        places = response.fetch('places', [])

        places.collect do |e|
          ::LibTAD::Places::Place.new(e)
        end
      end
    end
  end
end
