require 'test_helper'

class BadApiKeyTest < Test::Unit::TestCase
  def test_raise_exception
    GoGoodreads.configure do |config|
      config.api_key = "1IlntIwcUm5CpTbQhu7Zf"
    end

    VCR.use_cassette 'book_by_isbn_bad_api_key' do
      assert_raise ::GoGoodreads::BadApiKey do
        GoGoodreads::Book.show_by_isbn("0441172717")
      end
    end
  end
end
