module ApiWrapper
  class BaseModel
    def self.routes 
      {}
    end

    def self.method_missing(name, *args)
      silent_failure = true
      str_name = name.to_s
      if str_name[-1] == '!'
        name = str_name.gsub('!', '').to_sym
        silent_failure = false
      end

      url, method = routes[name]
      return super unless url
      request_params = args[0]
      url_params = args[1] ? args[1] : nil
      if url_params
        url = url % url_params
      end

      request = CoreRequest.new(uri: url, method: method,
                                silent_failure: silent_failure,
                                data: request_params)
      return request.send
    end
  end
end
