module GoGoodreads
  module Resource
    def initialize(attrs = {})
      attrs.each {|k, v| instance_variable_set("@#{ k }", v) }
    end
  end
end
