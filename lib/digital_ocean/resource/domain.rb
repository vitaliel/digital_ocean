module DigitalOcean
  module Resource
    # https://cloud.digitalocean.com/api_access
    class Domain < Base

      # Lists account domains
      # @return [Hashie::Rash] A hash with API response, !{status: 'OK', domains: [...]}
      #
      # @example
      #   resp = client.domains.list
      #
      #   if resp.status == 'OK'
      #     resp.domains.each do |domain|
      #       puts "#{domain.id} #{domain.name} #{domain.ttl}"
      #       puts domain.life_zone_file
      #     end
      #   else
      #     puts 'Error: ' + resp.message
      #   end
      def list
        @connection.get('/domains').body
      end

      # Creates a domain
      # @param params [Hash] a hash with properties for domain
      # @option params name [String] a name for the domain, ie example.com
      # @option params ip_address [String] an IP address for the domain, ie 8.8.8.8
      # @return [Hashie::Rash] a hash with API response
      # @example
      #   resp = client.domains.create(name: 'example.com', ip_address: '8.8.8.8')
      def create(params)
        @connection.get '/domains/new' do |query|
          apply_params(query, params)
        end.body
      end

      # Gets domain information
      # @param domain_id [Integer] ID for the domain
      # @return [Hashie::Hash] a hash with API response
      def show(domain_id)
        @connection.get("/domains/#{domain_id}").body
      end

      # Removes domain and all its records
      # @param domain_id [Integer] ID for the domain to be removed
      def delete(domain_id)
        @connection.get("/domains/#{domain_id}/destroy").body
      end

      # Returns domain records
      # @param domain_id [Integer] ID for the domain
      # @return [Hashie::Rash]
      def list_records(domain_id)
        @connection.get("/domains/#{domain_id}/records").body
      end

      # Create a dns record for the domain
      # @param domain_id [Integer] ID for the domain obtained from {#create} or {#list} methods
      def create_record(domain_id, opts = {})
        @connection.get "/domains/#{domain_id}/records/new" do |query|
          apply_params(query, opts)
        end.body
      end

      def show_record(domain_id, rec_id, opts = {})
        @connection.get "/domains/#{domain_id}/records/#{rec_id}" do |query|
          apply_params(query, opts)
        end.body
      end

      def edit_record(id, rec_id, opts = {})
        @connection.get "/domains/#{id}/records/#{rec_id}/edit" do |query|
          apply_params(query, opts)
        end.body
      end

      def delete_record(id, rec_id)
        @connection.get("/domains/#{id}/records/#{rec_id}/destroy").body
      end
    end
  end
end
