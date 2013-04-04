module ApiWrapper
  class ApiWrapperException < Exception
  end

  EXCEPTIONS = [{  :class_name => "UnauthorizedRequest",
                   :error_message => "You are not authorized to get this resource",
                   :http_status => 401
                },
                {
                  :class_name => "ApiError",
                  :error_message => "Internal server error",
                  :http_status => 500
                },
                {
                  :class_name => "InvalidResponse",
                  :error_message => "Invalid response from server",
                  :http_status => 500
                },
                {
                  :class_name => "NoResponse",
                  :error_message => "Empty response",
                  :http_status => 0
                }
  ]

  EXCEPTIONS.each do |attributes|
    aux_name = attributes.delete(:class_name) 
    aux_class = Class.new(ApiWrapperException)do
                  attributes.each do |key, value|
                    define_method key do
                      value
                    end
                  end
                end
    self.const_set(aux_name, aux_class)
  end
end
