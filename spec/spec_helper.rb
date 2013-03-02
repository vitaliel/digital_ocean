$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'coveralls'
Coveralls.wear!

require 'rspec/autorun'
require 'digital_ocean'

if ENV['RECORDING']
  CLIENT_ID = ENV['DIGITAL_OCEAN_CLIENT_ID']
  API_KEY   = ENV['DIGITAL_OCEAN_API_KEY']
else
  CLIENT_ID = 'client_id_XXXXXXXXXXXXXXXXXXX'
  API_KEY   = 'api_key_YYYYYYYYYYYYYYYYYYYYY'
end

RSpec.configure do |c|
  # VCR:
  # so we can use :vcr rather than :vcr => true;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

