module GoGoodreads
  class Shelf < Resource
    attr :name

    def self.initialize_with_node(xml)
      new(:name => xml['name'])
    end
  end
end

