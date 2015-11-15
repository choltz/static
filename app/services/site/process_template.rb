# Public: Given a template name, find the corresponding template file and
# process it into html
Namespace.build('Services::Site::ProcessTemplate') do
  include Services::Base

  attr_accessor :path,
                :template

  # Public: Constructor - save the template name for use in the call method
  #
  # template - symbol or string
  # path     - path to template file (default: 'app/views')
  def initialize(template, path = 'app/views')
    @template = template
    @path     = path
  end

  # Public: Process the template and store on the options hash using the name
  # given in the constructor
  #
  # options - parameter hash
  #
  # Returns: modified parameter hash
  #   key added based on the constructor, symbol.
  def call(options = {})
    options.tap do |opts|
      opts[@template.to_sym] = Slim::Template.new("#{@path}/#{@template}.slim").render(Object.new, data: opts)
    end
  end
end
