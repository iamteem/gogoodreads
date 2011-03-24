module GoGoodreads
  module Resource
    def self.included(base)
      base.__send__(:include, Attributes)
    end

    def initialize(attrs = {})
      attrs.each {|k, v| instance_variable_set("@#{ k }", v) }
    end
  end
end
