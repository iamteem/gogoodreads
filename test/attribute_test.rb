require 'test_helper'
require 'nokogiri'

class AttributeTest < Test::Unit::TestCase
  class Thing
    include GoGoodreads::Resource

    attribute :klazz_id,   :map_from => 'id'
    attribute :page_count, :type => Integer
    attribute :simple
    attribute :date_added, :type => Time

    def self.initialize_with_node(xml)
      new(to_attributes!(xml))
    end
  end

  def setup
    xml = "<xmlrootResponse><things><thing><id>123</id><page_count>523</page_count><simple><![CDATA[Hello, World!]]></simple><date_added>Fri Jun 01 19:11:54 -0700 2007</date_added></thing></things></xmlrootResponse>"
    node = ::Nokogiri::XML(xml)
    @thing = Thing.initialize_with_node(node.search('things > thing').first)
  end

  def test_parsing
    assert_equal "123", @thing.klazz_id
    assert_equal 523, @thing.page_count
    assert_equal "Hello, World!", @thing.simple
    assert_equal Time.parse("Fri Jun 01 19:11:54 -0700 2007"), @thing.date_added
  end
end
