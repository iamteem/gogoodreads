require 'spec_helper'

describe GoGoodreads, '.configure' do
  it "should set up the api_key and the secret_key" do
    GoGoodreads.configure do |config|
      config.api_key = "someapikey"
      config.secret = "secret"
    end

    GoGoodreads::Config.api_key.should == "someapikey"
    GoGoodreads::Config.secret.should == "secret"
  end
end
