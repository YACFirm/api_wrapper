require 'rubygems'
require 'bundler/setup'

require 'api_wrapper'

module ApiWrapper
  @@previous_config = nil

  def self.cache_config_for_test
    @@previous_config = ApiWrapper.configuration.clone
  end

  def self.reset_for_test
    @@configuration = @@previous_config if @@previous_config
  end
end

RSpec.configure do |config|
  config.before :each do
    ApiWrapper.cache_config_for_test
  end

  config.after :each do
    ApiWrapper.reset_for_test
  end
end
