module ApiWrapper
  class BaseModel
    class << self
      include ApiWrapper::CoreRequest
    end

    def self.routes 
      {}
    end

    def self.method_missing(name, *args)
      url, method = routes[name]
      return super unless url
      request_params = args[0]
      url_params = args[1] ? args[1] : nil
      if url_params
        url = url % url_params
      end
      return make_request(url, method, request_params)
    end
  end
end
