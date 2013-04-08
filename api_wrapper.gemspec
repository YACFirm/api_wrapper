Gem::Specification.new do |spec|

  spec.name = 'api_wrapper'
  spec.version = '0.1'
  spec.date = '2013-02-14'
  spec.summary = "Wrap APIs and use them as local API"
  spec.description = "An easy way to wrap REST apis"
  spec.authors = ["Jesus Geronimo"]
  spec.email = 'geronimo@yacfirm.com'
  spec.homepage = 'http://www.yacfirm.com'
  spec.add_dependency('typhoeus', '~> 0.6.1')

  spec.files = Dir['lib/*.rb'] + Dir['lib/**/*.rb']

end
