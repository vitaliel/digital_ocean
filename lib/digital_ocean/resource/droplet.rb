module DigitalOcean
  module Resource
    class Droplet < Base

      def list(opts = {})
        @connection.get '/droplets' do |query|
          apply_params(query, opts)
        end.body
      end

      def show(id, opts = {})
        @connection.get "/droplets/#{id}" do |query|
          apply_params(query, opts)
        end.body
      end

    end
  end
end
