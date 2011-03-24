module GoGoodreads
  class User
    include GoGoodreads::Resource

    attribute :user_id, :map_from => 'id'
    attribute :name
    attribute :location
    attribute :link
    attribute :image_url
    attribute :small_image_url

    def self.initialize_with_node(xml)
      new(to_attributes!(xml))
    end
  end
end
