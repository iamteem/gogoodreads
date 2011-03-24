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

  def self.configure(&block)
    yield GoGoodreads::Config
  end
end
