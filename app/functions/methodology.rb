module Methodology
  def self.included(klass)
    klass.send :include, InstanceMethods
    klass.send :extend,  ClassMethods
    klass.instance_variable_set '@functions', {}
  end

  module InstanceMethods
  end

  module ClassMethods
    def function(name, &block)
      @functions[name.to_sym] = FunctionService.new(name, block)

      define_singleton_method name do
        @functions[name.to_sym]
      end
    end
  end

  class FunctionService
    attr_accessor :name, :block
    def initialize(name, block)
      @name  = name
      @block = block
    end

    def call(*args)
      @block.call(*args)
    end

    def |(klass)
      Composition.new(self, klass)
    end
  end

  class Composition
    attr_accessor :functions

    def initialize(*functions)
      @functions = functions
    end

    def |(klass)
      @functions << klass
      self
    end

    def call(*args)
      @functions.inject(args){ |args, function|  args = function.call(*args)  }
    end
  end
end
