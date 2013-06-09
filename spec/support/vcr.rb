require 'vcr'
require 'pp'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr/cassettes'
  c.hook_into :faraday
  c.configure_rspec_metadata!

  if ENV['RECORDING']
    c.filter_sensitive_data('client_id_XXXXXXXXXXXXXXXXXXX') { ENV['DIGITAL_OCEAN_CLIENT_ID'] }
    c.filter_sensitive_data('api_key_YYYYYYYYYYYYYYYYYYYYY') { ENV['DIGITAL_OCEAN_API_KEY']   }
  end

  # modern DigitalOcean API frontend doesn't send cookie_set header

  c.filter_sensitive_data('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') do |http_interaction|
    http_interaction.response.headers['etag'].first
  end
end
