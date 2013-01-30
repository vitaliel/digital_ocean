module DigitalOcean
  module Resource
    class Region < Base
      # @return [Hashie::Rash] List of all regions
      # @example
      #   regions = client.regions.list
      def list
        @connection.get('/regions').body
      end
    end
  end
end
