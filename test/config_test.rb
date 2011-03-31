require 'test_helper'

class ConfigureTest < Test::Unit::TestCase
  def test_api_key_setup
    GoGoodreads.configure do |config|
      config.api_key = "someapikey"
      config.secret = "secret"
    end

    assert_equal "someapikey", GoGoodreads::Config.api_key
    assert_equal "secret", GoGoodreads::Config.secret
  end
end
