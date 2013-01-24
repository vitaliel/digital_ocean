# DigitalOcean
[![Build Status](https://travis-ci.org/rmoriz/digital_ocean.png)](https://travis-ci.org/rmoriz/digital_ocean)

DigitalOcean provides simple cloud hosting. Create and delete
SSD-based virtual machines within seconds for a very affordable price.

Go to https://www.digitalocean.com/ for more information.

This gem is a simple ruby wrapper for the HTTP API of DigitalOcean using
the great [Faraday](https://github.com/lostisland/faraday) library.


## Installation

Add this line to your application's Gemfile:

    gem 'digital_ocean'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install digital_ocean

## Prerequisite: Create an account and API credentials

TODO

## Usage

### Create a client instance

```ruby
require 'digital_ocean'

dc = DigitalOcean::API.new :client_id => 'YOUR_CLIENT_ID', 
                           :api_key   => 'YOUR_API_KEY'
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT

## Copyright

2013 Moriz GmbH, https://moriz.de/

