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

  c.filter_sensitive_data('_digitalocean2_session=wtf') do |http_interaction|
    http_interaction.response.headers['set-cookie'].first
  end

  c.filter_sensitive_data('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') do |http_interaction|
    http_interaction.response.headers['etag'].first
  end
end
