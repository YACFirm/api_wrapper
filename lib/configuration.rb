module ApiWrapper
  # Configures ApiWrapper.
  def self.configure(configuration = ApiWrapper::Configuration.new)
    yield configuration if block_given?
    @@configuration = configuration
  end

  def self.configuration # :nodoc:
    @@configuration ||= ApiWrapper::Configuration.new
  end

  # ApiWrapper can be configured using the ApiWrapper.configure method. For example:
  #
  #   ApiWrapper.configure do |config|
  #     config.show_whiny_errors = false
  #   end
  class Configuration
    # Should whiny error messages be shown?
    attr_accessor :show_whiny_errors

    attr_accessor :api_url, :api_access_token

    def initialize # :nodoc:
      self.show_whiny_errors = true
    end

    # some syntactic sugar for you, the coder
    def show_whiny_errors? #:nodoc:
      @show_whiny_errors ? true : false
    end
  end
end
