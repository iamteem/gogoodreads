module GoGoodreads
  class Author < Resource
    attr :author_id, :name, :image_url,
         :small_image_url, :link,
         :average_rating, :ratings_count,
         :text_reviews_count

    def self.initialize_with_node(xml)
      attrs = {}

      attrs[:author_id] = xml.at('id').text
      attrs[:name] = xml.at('name').text
      attrs[:image_url] = xml.at('image_url').text
      attrs[:small_image_url] = xml.at('small_image_url').text
      attrs[:link] = xml.at('link').text
      attrs[:average_rating] = xml.at('average_rating').text.to_f
      attrs[:ratings_count] = xml.at('ratings_count').text.to_i
      attrs[:text_reviews_count] = xml.at('text_reviews_count').text.to_i

      new(attrs)
    end
  end
end
