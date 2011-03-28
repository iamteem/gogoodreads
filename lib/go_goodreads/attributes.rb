module GoGoodreads
  module Attributes
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # @param [Symbol] name the name of the attribute
      # @param [Hash] opts the options to configure the attribute
      # @option opts [Class]  :type the class of the parsed value of the attribute
      # @option opts [Proc]   :using a proc object to be used when finding the value in an xml node
      # @option opts [Symbol] :map_from a symbol where the value is placed when calling to_attributes!
      def attribute(name, opts = {})
        default_options = { :type => String, :map_from => name }
        setting = default_options.merge(opts)
        setting[:using] ||= lambda {|xml, from| (xml > from.to_s).text }
        @attributes ||= {}
        @attributes[name] = setting
        attr name
      end

      # @param [Nokogiri::Node] xml the xml to be used in getting the attributes
      # @param [Hash] options settings for overriding default attribute configuration (key is the name of the attribute, value is the options hash)
      def to_attributes!(xml, options = {})
        attrs = {}

        @attributes.each do |attr, config|
          opts = config.merge(options[attr] || {})
          map_from = opts[:map_from]
          callable = opts[:using]
          val = callable.call(xml, map_from)
          attrs[attr] = _convert(val, opts[:type]) rescue val
        end

        attrs
      end

      def Boolean(val)
        {"true" => true, "false" => false}[val]
      end

    private
      def _convert(val, type)
        if type == ::GoGoodreads::Attributes::Boolean
          Boolean(val)
        elsif type == Time
          Time.parse(val)
        elsif type == Integer
          Integer(val)
        elsif type == Float
          Float(val)
        else
          val
        end
      end
    end

    class Boolean; end

  end
end
