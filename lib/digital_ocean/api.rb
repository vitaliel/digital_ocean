module DigitalOcean
  class API
    def initialize(params)
      @client_id       = params[:client_id]
      @api_key         = params[:api_key]
      @debug           = params[:debug]
      @base_url        = params[:base_url]        || 'https://api.digitalocean.com/'
      @faraday_adapter = params[:faraday_adapter] || Faraday.default_adapter
      @faraday         = params[:faraday]         || default_faraday

      raise ArgumentError, ':client_id missing' unless @client_id
      raise ArgumentError, ':api_key missing' unless @api_key
    end

    def droplets
      DigitalOcean::Resource::Droplet.new(@faraday)
    end

    def sizes
      DigitalOcean::Resource::Size.new(@faraday)
    end

    def regions
      DigitalOcean::Resource::Region.new(@faraday)
    end

    def ssh_keys
      DigitalOcean::Resource::SSHKey.new(@faraday)
    end

    def images
      DigitalOcean::Resource::Image.new(@faraday)
    end

    def default_faraday
      Faraday.new(:url => @base_url) do |faraday|
        faraday.use AuthenticationMiddleware, @client_id, @api_key
        faraday.request  :url_encoded
        faraday.response :rashify
        faraday.response :json
        faraday.response(:logger) if @debug
        faraday.adapter @faraday_adapter
      end
    end
  end
end
