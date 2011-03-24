module GoGoodreads
  class User
    include GoGoodreads::Resource

    attr :user_id, :name, :location, :link,
         :image_url, :small_image_url

    def self.initialize_with_node(xml)
      attrs = {}
      attrs[:user_id] = xml.at('id').text
      attrs[:name] = xml.at('name').text
      attrs[:location] = xml.at('location').text
      attrs[:link] = xml.at('link').text
      attrs[:image_url] = xml.at('image_url').text
      attrs[:small_image_url] = xml.at('small_image_url').text

      new(attrs)
    end
  end
end
