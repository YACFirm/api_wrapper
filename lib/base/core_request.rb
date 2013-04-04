module ApiWrapper
  module CoreRequest
    def make_request (uri, method, data={})
      params = {}
      params[:method] = method
      insert_common_headers(params)

      if method == :get
        params[:params] = data
      else
        params[:body] = data
        jsonify_body(params)
      end

      response = Typhoeus::Request.send(method, "#{ApiWrapper.configuration.api_url}#{uri}", params)

      if response.code == 401
        raise ApiWrapper::UnauthorizedRequest
      elsif response.code == 500
        raise ApiWrapper::ApiError
      elsif response.code == 0
        raise ApiWrapper::NoResponse
      end

      insert_parsed_body(response)
      return response
    end

    private

    def jsonify_body(data)
      data[:body] = JSON.dump(data[:body]) if data[:headers]["Content-Type"] == 'application/json'
    end

    def insert_parsed_body(response)
      def response.parsed_body (&block)
        if block
          @parsed_body = block.call
        end
        @parsed_body
      end

      response.parsed_body do
        JSON.parse(response.body)
      end
    end

    def access_token
      ApiWrapper.configuration.api_access_token
    end

    def insert_common_headers(data)
      data[:headers] = {} unless data[:headers]
      data[:headers][:Authorization] = "Oauth #{access_token}"
      content_type = 'application/json'
      data[:headers]["Content-Type"] = content_type if data[:headers]["Content-Type"].nil? and data[:method]!=:get
    end
  end
end
