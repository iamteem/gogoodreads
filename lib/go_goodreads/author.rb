module GoGoodreads
  class Author
    include GoGoodreads::Resource

    attribute :author_id, :map_from => 'id'
    attribute :name
    attribute :image_url
    attribute :small_image_url
    attribute :link
    attribute :average_rating, :type => Float
    attribute :ratings_count, :type => Integer
    attribute :text_reviews_count, :type => Integer

    def self.initialize_with_node(xml)
      new(to_attributes!(xml))
    end
  end
end
