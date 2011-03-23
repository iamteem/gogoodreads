module GoGoodreads
  class Resource
    def initialize(attrs = {})
      attrs.each {|k, v| instance_variable_set("@#{ k }", v) }
    end
  end
end
