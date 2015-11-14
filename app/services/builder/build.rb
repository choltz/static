require_relative '../base'

Namespace.build('Services::Builder::Build') do
  include Services::Base

  # Public: Build a static website from the temlates in app/views and the
  # posts in app/posts
  def call(options = {})
    # Generate post content
    posts = Dir['app/posts/*'].map do |file|
      (Services::Posts::OpenFile        |
       Services::Posts::ParseProperties |
       Services::Posts::ParseMarkdown   |
       Services::HashToOpenStruct).call(file: file)
    end

    # Generate site files
    (Services::Site::GeneratePostPages |
     Services::Site::GenerateStructure |
     Services::Site::WriteFiles).call(posts: posts)

    #layout
    #sidebar

    #main page - listing
    #post page


    options
  end
end
