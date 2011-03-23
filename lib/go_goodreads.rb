module GoGoodreads
  autoload :Config,  'go_goodreads/config'
  autoload :Book,    'go_goodreads/book'
  autoload :Request, 'go_goodreads/request'
  autoload :Author,  'go_goodreads/author'

  def self.configure(&block)
    yield GoGoodreads::Config
  end
end
