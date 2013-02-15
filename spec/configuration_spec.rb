require 'spec_helper'
 
describe ApiWrapper::Configuration do
  it 'should show whiny errors by default' do
    config = ApiWrapper::Configuration.new
    config.show_whiny_errors?.should be_true
  end
  
  it 'should be configurable with a block' do
    ApiWrapper.configure do |config|
      config.api_url = "www.test.com"
      config.show_whiny_errors = false
    end
    
    config = ApiWrapper.configuration
    config.show_whiny_errors?.should be_false
  end
end
