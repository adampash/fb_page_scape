require_relative '../db/init_test.rb'
require 'vcr'
require 'rspec'
SECRETS = YAML::load(IO.read('config/secrets.yml'))

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  # config.filter_run :focus => true
end
