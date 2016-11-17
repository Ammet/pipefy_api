module PipefyAPI
  class BaseEntity
    attr_accessor :body

    def initialize(body)
      @body = body.is_a?(String) ? JSON.parse(body) : body

      @body.each do |attribute, _|
        define_attribute_method(attribute)
      end
    end

    def define_attribute_method(attribute)
      define_singleton_method(attribute) { @body[attribute] }
    end
  end
end
