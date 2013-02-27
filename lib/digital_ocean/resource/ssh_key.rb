module DigitalOcean
  module Resource
    class SSHKey < Base
      def list
        @connection.get('/ssh_keys').body
      end

      def show(id)
        @connection.get("/ssh_keys/#{id}").body
      end

      def delete(id)
        @connection.get("/ssh_keys/#{id}/destroy").body
      end

      def add(args)
        @connection.get('/ssh_keys/new') do |query|
          apply_params(query, args)
        end.body
      end

      def edit(id, args)
        @connection.get("/ssh_keys/#{id}/edit") do |query|
          apply_params(query, args)
        end.body
      end
    end
  end
end
