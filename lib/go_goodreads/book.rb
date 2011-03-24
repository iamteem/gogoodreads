module GoGoodreads
  class Book
    include GoGoodreads::Resource
    extend GoGoodreads::Request

    attribute :title
    attribute :isbn
    attribute :isbn13
    attribute :image_url
    attribute :small_image_url
    attribute :description
    attribute :asin
    attribute :url
    attribute :link
    attribute :num_pages, :type => Integer
    attr      :authors, :reviews

    attr_accessor :current_page

    def self.show_by_isbn(isbn, options = {})
      params = { :isbn => isbn }
      params.merge!(options)

      request('/book/isbn', params) do |xml|
        book = initialize_with_node(xml)
        book.current_page = params[:page] || 1
        book
      end
    end


    def self.initialize_with_node(xml)
      attrs = to_attributes!(xml)
      attrs.delete_if { |k,v| v.respond_to?(:empty?) && v.empty? }

      book = new(attrs)
      book.initialize_authors_with_nodeset(xml.search('authors > author'))
      book.initialize_reviews_with_nodeset(xml.search('reviews > review'))
      book
    end

    def initialize_authors_with_nodeset(xml)
      @authors = xml.map {|n| GoGoodreads::Author.initialize_with_node(n) }
    end

    def initialize_reviews_with_nodeset(xml)
      @reviews = xml.map {|n| GoGoodreads::Review.initialize_with_node(n) }
    end
  end
end
