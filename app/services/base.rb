module Services
  # Service class extensions
  module Base
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Public: override | operator to use as short-hand to compose multiple
    # services
    def |(value)
      Services::Compose.new self, value
    end

    # class-level methods to mixin
    module ClassMethods
      # Public: Delegate the call method to an internal instance of the class
      def call(*args, &block)
        @instance ||= new
        @instance.call(*args, &block)
      end

      # Public: override | operator to use as short-hand to compose multiple
      # services
      def |(value)
        Services::Compose.new self, value
      end
    end
  end
end
