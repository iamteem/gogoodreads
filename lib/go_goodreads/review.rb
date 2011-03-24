module GoGoodreads
  class Review
    include GoGoodreads::Resource

    attr :review_id, :user, :shelves, :rating,
         :votes, :spoiler_flag, :date_added,
         :date_updated, :read_count, :body,
         :comments_count, :url, :link

    def self.initialize_with_node(xml)
      attrs = {}

      attrs[:review_id] = xml.at('id').text
      attrs[:votes] = xml.at('votes').text.to_i
      sf = xml.at('spoiler_flag').text
      attrs[:spoiler_flag] = !(sf || sf == "false")
      attrs[:date_added] = Time.parse(xml.at('date_added').text)
      attrs[:date_updated] = Time.parse(xml.at('date_updated').text)
      attrs[:read_count] = xml.at('read_count').text.to_i
      attrs[:body] = xml.at('body').text
      attrs[:comments_count] = xml.at('comments_count').text.to_i
      attrs[:url] = xml.at('url').text
      attrs[:link] = xml.at('link').text

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
