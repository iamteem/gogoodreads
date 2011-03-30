module GoGoodreads
  autoload :Config,     'go_goodreads/config'
  autoload :Request,    'go_goodreads/request'
  autoload :Resource,   'go_goodreads/resource'
  autoload :Book,       'go_goodreads/book'
  autoload :Author,     'go_goodreads/author'
  autoload :Shelf,      'go_goodreads/shelf'
  autoload :Review,     'go_goodreads/review'
  autoload :User,       'go_goodreads/user'
  autoload :Attributes, 'go_goodreads/attributes'

  # Allows you to set the Goodreads API key to be used when using the API.
  # @yield [config] Block that setups the configuration of GoGoodreads.
  # @example
  #   GoGoodreads.configure do |config|
  #     config.api_key = "somesecretapikey"
  #   end
  def self.configure(&block)
    yield GoGoodreads::Config
  end


  class BadApiKey < Exception; end
end
