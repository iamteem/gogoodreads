require 'open-uri'
require 'cgi'
require 'nokogiri'

module GoGoodreads
  module Request
    BASE_URL = "http://www.goodreads.com"

    # Does the HTTP request and converting to Nokogiri::XML.
    # @param [String] path path of the request.
    # @param [Hash] params Goodreads API params to be passed with the request.
    # @yield [xml] Consume/parse the xml.
    def request(path, params = {}, &block)
      params.merge!(:key => GoGoodreads::Config.api_key)

      uri = build_uri(path, to_querystring(params))
      yield Nokogiri::XML(open(uri))
    end

  private
    # Converts String to query string.
    def to_querystring(params)
      params.map do |k, v|
        "#{ k }=#{ CGI.escape(v) }"
      end.join('&')
    end

    # build the uri based on the base url, path, and params.
    def build_uri(path, params)
      [BASE_URL, path, '?', params].join
    end
  end
end
