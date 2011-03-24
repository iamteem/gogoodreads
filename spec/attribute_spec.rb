require 'spec_helper'

describe GoGoodreads::Attributes do
  before(:all) do
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

  end

  before(:each) do
    xml = "<xmlrootResponse><things><thing><id>123</id><page_count>523</page_count><simple><![CDATA[Hello, World!]]></simple><date_added>Fri Jun 01 19:11:54 -0700 2007</date_added></thing></things></xmlrootResponse>"
    node = Nokogiri::XML(xml)
    @thing = Thing.initialize_with_node(node.search('things > thing').first)
  end

  it "parses the attributes from the xml node correctly" do
    @thing.klazz_id.should == "123"
    @thing.page_count.should == 523
    @thing.simple.should == "Hello, World!"
    @thing.date_added.should == Time.parse("Fri Jun 01 19:11:54 -0700 2007")
  end
end
