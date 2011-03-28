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
    attribute :text_reviews_count, :type => Integer
    attribute :average_rating, :type => Float
    attribute :data
    attribute :language_code
    attribute :publisher
    attribute :publication_day, :type => Integer
    attribute :publication_month, :type => Integer
    attribute :publication_year, :type => Integer

    attr      :authors, :reviews

    attr_accessor :current_page

    # @param [String] isbn ISBN of the book
    # @param [Hash] opts Option passed to the API call, except the ISBN.
    # @option opts [Integer] :page (1) Page number
    # @return [GoGoodreads::Book]
    def self.show_by_isbn(isbn, opts = {})
      params = { :isbn => isbn }
      params.merge!(opts)

      request('/book/isbn', params) do |xml|
        book = initialize_with_node(xml.root.at('book'))
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


    def publication_date
      if publication_day && publication_year && publication_month
        Date.new(publication_year, publication_month, publication_day)
      end
    end
  end
end
