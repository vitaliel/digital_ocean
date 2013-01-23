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
        @connection.delete("/ssh_keys/#{id}").body
      end

      #def add(args)
      #  @connection.get('/ssh_keys.json') do |query|
      #    apply_params(query, args)
      #  end.body
      #end
      #
      #def edit
      #end
      #
    end
  end
end
