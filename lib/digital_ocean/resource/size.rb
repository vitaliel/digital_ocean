module DigitalOcean
  module Resource
    class Size < Base
      def list
        @connection.get('/sizes').body
      end
    end
  end
end
