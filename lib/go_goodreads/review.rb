module GoGoodreads
  class Review
    include GoGoodreads::Resource

    attribute :review_id, :map_from => 'id'
    attribute :votes, :type => Integer
    attribute :spoiler_flag, :type => Boolean
    attribute :date_added, :type => Time
    attribute :date_updated, :type => Time
    attribute :body
    attribute :read_count, :type => Integer
    attribute :comments_count, :type => Integer
    attribute :url
    attribute :link

    attr :user, :shelves

    def self.initialize_with_node(xml)
      attrs = to_attributes!(xml)
      review = new(attrs)
      review.initialize_user_with_node(xml.at('user'))
      review.initialize_shelves_with_nodes(xml.search('shelves > shelf'))
      review
    end

    def initialize_user_with_node(xml)
      @user = GoGoodreads::User.initialize_with_node(xml)
    end

    def initialize_shelves_with_nodes(shelves_xml)
      @shelves = shelves_xml.map do |xml|
        GoGoodreads::Shelf.initialize_with_node(xml)
      end
    end
  end
end
