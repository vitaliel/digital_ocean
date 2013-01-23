module DigitalOcean
  module Resource
    class Region < Base
      def list
        @connection.get('/regions').body
      end
    end
  end
end
