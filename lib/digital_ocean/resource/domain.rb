module DigitalOcean
    module Resource
        class Domain < Base

            def list(opts = {})
                @connection.get '/domains' do |query|
                    apply_params(query, opts)
                end.body
            end

            def create(params)
                @connection.get '/domains/new' do |query|
                    apply_params(query, params)
                end.body
            end

            def show(id, opts = {})
                @connection.get "/domains/#{id}" do |query|
                    apply_params(query, opts)
                end.body
            end

            def delete(id)
                @connection.get ("/domains/#{id}/destroy").body
            end

            def list_records(id, opts = {})
                @connection.get "/domains/#{id}/records" do |query|
                    apply_params(query, opts)
                end.body
            end

            def create_record(id, opts = {})
                @connection.get "/domains/#{id}/records/new" do |query|
                    apply_params(query, opts)
                end.body
            end

            def show_record(id, rec_id, opts = {})
                @connection.get "/domains/#{id}/records/#{rec_id}" do |query|
                    apply_params(query, opts)
                end.body
            end

            def delete_record(id, rec_id, opts = {})
                @connection.get "/domains/#{id}/records/#{rec_id}/destroy" do |query|
                    apply_params(query, opts)
                end.body
            end

        end
    end
end
