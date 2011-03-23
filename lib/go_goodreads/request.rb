require 'open-uri'
require 'cgi'
require 'nokogiri'

module GoGoodreads
  module Request
    BASE_URL = "http://www.goodreads.com"

    def request(path, params = {})
      params.merge!(:key => GoGoodreads::Config.api_key)

      uri = build_uri(path, to_querystring(params))
      yield Nokogiri::XML(open(uri))
    end

    def to_querystring(params)
      params.map do |k, v|
        "#{ k }=#{ CGI.escape(v) }"
      end.join('&')
    end

    def build_uri(path, params)
      [BASE_URL, path, '?', params].join
    end
  end
end
