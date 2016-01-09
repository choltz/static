# Convert a list of files into a list of file contents

Namespace.build('Services::Posts::OpenFile') do
  include Services::Base

  # Public: Open the given file and write the contents to the :contents key
  #
  # file - file path
  #
  # Returns: modified parameter hash
  #   contents: array of file contents
  def call(file)
    File.open(file).read
  end
end
