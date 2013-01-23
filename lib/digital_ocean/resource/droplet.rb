module DigitalOcean
  module Resource
    class Droplet < Base
      def initialize(connection)
        @connection = connection
      end

      def list(opts = {})
        @connection.get '/droplets' do |query|
          apply_params(query, opts)
        end.body
      end
    end
  end
end
