module DigitalOcean
  class API
    # Creates a new API client instance.
    #
    # @param [Hash] params
    # @option params [String] :client_id The client_id (required)
    # @option params [String] :api_key The api_key (required)
    # @option params [String] :base_url ('https://api.digitalocean.com/') API base url
    # @option params [Symbol] :faraday_adapter ('Faraday.default_adapter')  Faraday adapter/http client library to use.
    # @raise [ArgumentError] when no client_id is provided
    # @raise [ArgumentError] when no api_key is provided
    # @example
    #   client = DigitalOcean::API.new :client_id => '######', :api_key => '#######'
    #
    # @see [Faraday]
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

    # Access Droplets (virtual machines)
    # @see DigitalOcean::Resource::Droplet
    # @return [DigitalOcean::Resource::Droplet]
    def droplets
      DigitalOcean::Resource::Droplet.new(@faraday)
    end

    # Access Sizes (virtual machine types/sizes)
    # @see DigitalOcean::Resource::Size
    # @return [DigitalOcean::Resource::Size]
    def sizes
      DigitalOcean::Resource::Size.new(@faraday)
    end

    # Access Regions (data center location)
    # @see DigitalOcean::Resource::Region
    # @return [DigitalOcean::Resource::Region]
    def regions
      DigitalOcean::Resource::Region.new(@faraday)
    end

    # Access SSH keys
    # @see DigitalOcean::Resource::SSHKey
    # @return [DigitalOcean::Resource::SSHKey]
    def ssh_keys
      DigitalOcean::Resource::SSHKey.new(@faraday)
    end

    # Access Images (Snapshots, Backups)
    # @see DigitalOcean::Resource::Image
    # @return [DigitalOcean::Resource::Image]
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
