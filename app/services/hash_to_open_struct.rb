Namespace.build('Services::HashToOpenStruct') do
  include Services::Base

  def call(options = {})
    # flatten properties into the top hash structure
    properties = options.merge(options[:properties])
    OpenStruct.new properties
  end
end
