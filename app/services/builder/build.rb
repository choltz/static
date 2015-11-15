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

    #  Services::Site::GenerateStructure |

    structure_files = (Services::Site::ProcessTemplate.new(:sidebar) |
                       Services::Site::ProcessTemplate.new(:header)  |
                       Services::Site::ProcessTemplate.new(:list)).call(options)

#     content = Slim::Template.new('app/views/sidebar.slim').render(Object.new, posts: posts)


#debugger

    #   sidedbar, header, footer
    #   listing page
    #   post pages - via application slim generation

    # (Services::Site::GeneratePostPages |
    #  Services::Site::GenerateStructure |
    #  Services::Site::WriteFiles).call(posts: posts, data: options)

    #layout
    #sidebar

    #main page - listing
    #post page


    options
  end
end
