# Convert a list of files into a list of file contents

Namespace.build('Services::Posts::OpenFile') do
  include Services::Base

  # Public: Open the given file and write the contents to the :contents key
  #
  # options - parameter hash
  #   file: file path
  #
  # Returns: modified parameter hash
  #   contents: array of file contents
  def call(options = {})
    options.tap do |opts|
      opts[:contents] = File.open(opts[:file]).read
    end
  end
end
