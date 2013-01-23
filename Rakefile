#encoding: utf-8
require 'rubygems'
require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
desc 'Run RSpec'
RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--color', '--format nested']
end

desc 'Run rspec tests'
task :test => [:spec]


desc 'Remove sensitive api credentials from cassettes'
task :clean_cassettes do
  Dir.glob('spec/vcr/cassettes/**/*.yml').each do |filename|
    contents = File.read(filename)
    contents.gsub!(ENV['DIGITAL_OCEAN_CLIENT_ID'], 'client_id_XXXXXXXXXXXXXXXXXXX')
    contents.gsub!(ENV['DIGITAL_OCEAN_API_KEY'],   'api_key_YYYYYYYYYYYYYYYYYYYYY')
    contents.gsub!(/_session=(.*);/, 'YYYYYYYYYYYYYY')
    File.open(filename, 'w') {|file| file.write(contents) }
  end
end

task :default => :test


