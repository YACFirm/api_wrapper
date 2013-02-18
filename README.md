Generic APIs Wrapper
===================

This gem aims to abstract HTTP interactions between JSON APIs and ruby clients.

Installation
------------

Include it in your Gemfile:

    gem 'api_wrapper', git: https://github.com/YACFirm/api_wrapper.git

and run:

    $ bundle install

Usage
=====

First of all you need to tell the gem where your API is, configure it in this way:

    require 'api_wrapper'

    ApiWrapper.configure do |config|
      config.api_url = "www.test.com"
    end

Create a class that represents the remote resource and make it inherit from `ApiWrapper::BaseModel`. 

Add to the class a method called `self.routes`, that method returns a hash in wich the keys are method names and the values are lists with the route and the HTTP method it uses.

    Class Example < ApiWrapper::BaseModel
        def self.routes
            {
            create: ['/example', :post]
            remove: ['/example/%id', :delete] 
            }
        end
    end

Once you have the class you can call create and remove methods passing a hash with the params the request should have:

    new_example = Example.create({example: {name: "This is a test"}}
    new_example['name'] # => 'This is a test'

And you'll get a hash with the response already parsed.
