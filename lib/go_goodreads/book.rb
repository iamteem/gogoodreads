module GoGoodreads
  class Book
    extend GoGoodreads::Request

    def self.show_by_isbn(isbn)
      request('/book/isbn', :isbn => isbn) do |xml|
        initialize_with_node(xml)
      end
    end

    attr :title, :isbn, :isbn13, :image_url,
         :small_image_url, :description,
         :asin, :url, :link,
         :reviews_count, :num_pages, :authors

    def self.initialize_with_node(xml)
      attrs = {}
      attrs[:title] = xml.at('title').text
      attrs[:isbn] = xml.at('isbn').text
      attrs[:isbn13] = xml.at('isbn13').text
      attrs[:image_url] = xml.at('image_url').text
      attrs[:small_image_url] = xml.at('small_image_url').text
      attrs[:description] = xml.at('description').text
      attrs[:reviews_count] = xml.at('reviews_count').text.to_i
      attrs[:num_pages] = xml.at('num_pages').text.to_i
      attrs[:asin] = xml.at('asin').text
      attrs[:url] = xml.at('url').text
      attrs[:link] = xml.at('link').text
      attrs.delete_if { |k,v| v.respond_to?(:empty?) && v.empty? }

      book = new(attrs)
      book.initialize_authors_with_nodeset(xml.search('authors > author'))
      book
    end

    def initialize(attrs = {})
      attrs.each {|k, v| instance_variable_set("@#{ k }", v) }
    end

    def initialize_authors_with_nodeset(xml)
      @authors = xml.map {|n| GoGoodreads::Author.initialize_with_node(n) }
    end
  end
end
