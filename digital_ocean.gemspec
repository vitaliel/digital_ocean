# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'digital_ocean/version'

Gem::Specification.new do |gem|
  gem.name          = 'digital_ocean'
  gem.version       = DigitalOcean::VERSION
  gem.authors       = ['Roland Moriz']
  gem.email         = ['roland@moriz.de']
  gem.description   = %q{A Ruby gem to interact with DigitalOcean, a cloud hosting provider}
  gem.summary       = %q{This gem wraps the DigitalOcean API documented at https://api.digitalocean.com/}
  gem.homepage      = 'https://github.com/rmoriz/digital_ocean'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  if RUBY_PLATFORM == 'java'
    gem.add_runtime_dependency 'jruby-openssl'
  end

  gem.add_dependency 'faraday', '~> 0.8.4'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'json'
  gem.add_dependency 'rash'

  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-fsevent'

  gem.add_development_dependency 'vcr',     '~> 2.4'
  gem.add_development_dependency 'fakeweb', '~> 1.3.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'yard'
end
