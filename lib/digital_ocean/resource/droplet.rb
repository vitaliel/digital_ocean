module DigitalOcean
  module Resource
    class Droplet < Base

      def list(opts = {})
        @connection.get '/droplets' do |query|
          apply_params(query, opts)
        end.body
      end

      def show(id, opts = {})
        @connection.get "/droplets/#{id}" do |query|
          apply_params(query, opts)
        end.body
      end

      def create(params)
        @connection.get '/droplets/new' do |query|
          apply_params(query, params)
        end.body
      end

      def reboot(id)
        @connection.put("/droplets/#{id}/reboot").body
      end

      def power_cycle(id)
        @connection.put("/droplets/#{id}/power_cycle").body
      end

      def shutdown(id)
        @connection.put("/droplets/#{id}/shutdown").body
      end

      def power_on(id)
        @connection.put("/droplets/#{id}/power_on").body
      end

      def power_off(id)
        @connection.put("/droplets/#{id}/power_off").body
      end

      def reset_root_password(id)
        @connection.post("/droplets/#{id}/reset_root_password").body
      end

      def resize(id, params)
        @connection.get "/droplets/#{id}/resize" do |query|
          apply_params(query, params)
        end.body
      end

      def snapshot(id, params)
        @connection.get "/droplets/#{id}/snapshot" do |query|
          apply_params(query, params)
        end.body
      end

      def restore(id, params)
        @connection.post "/droplets/#{id}/restore" do |query|
          apply_params(query, params)
        end.body
      end

      def rebuild(id, params)
        @connection.post "/droplets/#{id}/rebuild" do |query|
          apply_params(query, params)
        end.body
      end

      def enable_backups(id)
        @connection.post("/droplets/#{id}/enable_backups").body
      end

      def disable_backups(id)
        @connection.post("/droplets/#{id}/disable_backups").body
      end

      def delete(id)
        @connection.delete("/droplets/#{id}/destroy").body
      end
    end
  end
end
