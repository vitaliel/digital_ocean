module DigitalOcean
  class AuthenticationMiddleware < Faraday::Middleware
    extend Forwardable
    def_delegators :'Faraday::Utils', :build_query

    def initialize(app, client_id, api_key)
      @client_id = client_id
      @api_key   = api_key

      super(app)
    end

    def call(env)
      auth_params = { 'client_id' => @client_id, 'api_key' => @api_key }
      env[:url].query = build_query auth_params

      @app.call(env)
    end
  end
end
