module DigitalOcean
  module Resource
    class SSHKey < Base
      def list
        @connection.get('/ssh_keys').body
      end
    end
  end
end
