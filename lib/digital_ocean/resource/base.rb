module DigitalOcean
  module Resource
    class Base
      attr_accessor :query

      def initialize(connection, options = {})
        @connection = connection
      end

      private

      def apply_params(query, opts)
        apply_default_params(query)

        opts.each_pair do |key, value|
          query.params[key] = value
        end
      end

      def apply_default_params(query)
      end
    end
  end
end
