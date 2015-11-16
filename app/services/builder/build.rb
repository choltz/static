require_relative '../base'

Namespace.build('Services::Builder::Build') do
  include Services::Base

  # Public: Build a static website from the temlates in app/views and the
  # posts in app/posts
  def call(options = {})
    # Generate post objects based on markdown files
    options[:posts] = Dir['app/posts/*'].map do |file_path|
      (Services::Posts::OpenFile        |
       Services::Posts::ParseProperties |
       Services::Posts::ParseMarkdown   |
       Services::HashToOpenStruct).call(file: file_path)
    end

    # Generate site files
    structure = (Services::Site::ProcessTemplate.new(:sidebar) |
                 Services::Site::ProcessTemplate.new(:header)  |
                 Services::Site::ProcessTemplate.new(:list)).call(options)

    Services::Site::ProcessTemplate.new(:list).call(options)

    options
  end
end
