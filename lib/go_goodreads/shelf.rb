module GoGoodreads
  class Shelf
    include GoGoodreads::Resource
    attribute :name

    def self.initialize_with_node(xml)
      attrs = to_attributes!(xml, :name => {:using => lambda {|n, from| xml[from] }})
      new(attrs)
    end
  end
end

