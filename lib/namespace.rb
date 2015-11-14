# Public: Define a namespace and class chain, evalute the contents of the given
# block into the class name at the end of the chain
class Namespace
  # Public: build a class with the given namespace chain
  #
  # class_path      - string containing modules and class
  # inherited_class - class object - new class will inherit from this class
  # block           - block to evaluate into the class
  #
  # Example:
  #
  #   Namespace.build('Services::Posts::Get') do
  #     def call(options = {})
  #       puts 'buh'
  #     end
  #   end
  #
  # Services::Posts::Get.new.call
  # => 'buh'
  def self.build(class_path, inherited_class = nil, &block)
    names        = class_path.split('::')
    class_name   = names.pop
    names        = names.reverse
    inner_module = build_modules(Object, names)
    klass        = inherited_class.nil? ? Class.new : Class.new(inherited_class)

    inner_module.const_set class_name, klass
    klass.class_eval(&block)
  end

  # Internal: recursively build a chain of module names into a module hierarchy
  #
  # parent_module - strarting point: build modules into this module
  # chain         - array of strings: module names to builde
  #
  # Example:
  #   Namespace.build_modules(Kernel, ['Services', 'Posts'])
  #   puts Services::Posts
  #   => Kernel::Services::Posts
  def self.build_modules(parent_module, chain)
    return parent_module if chain.empty?

    child_module_name = chain.pop

    if parent_module.constants.include?(child_module_name.to_sym)
      child_module = parent_module.const_get(child_module_name)
    else
      child_module = Module.new
      parent_module.const_set child_module_name, child_module
    end

    build_modules child_module, chain
  end
end
