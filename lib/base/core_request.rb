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
      end
      jsonify_body(params)

      response = Typhoeus::Request.send(method, "#{APP_CONFIG['ouranos_api_host']}#{uri}", params)
      insert_parsed_body(response)
      if response.code == 401
        raise Exception.new("Unauthorized")
      elsif response.code == 500
        raise Exception.new("Api Error")
      end
      return response
    end

    private

    def jsonify_body(data)
      data[:body] = JSON.dump(data[:body]) if data[:body] and data[:headers]["Content-Type"] == 'application/json'
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
      APP_CONFIG['api_access_token']
    end

    def insert_common_headers(data)
      data[:headers] = {} unless data[:headers]
      data[:headers][:Authorization] = "Oauth #{access_token}"
      content_type = 'application/json'
      data[:headers]["Content-Type"] = content_type unless data[:headers]["Content-Type"]
    end
  end
end
