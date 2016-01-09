Namespace.build('Services::Builder::Build') do
  include Services::Base

  # Public: Build a static website from the temlates in app/views and the
  # posts in app/posts
  def call
    Slim::Engine.options[:disable_escape] = true

    file = Dir['app/posts/*'].first



    contents = (Posts.open_file        |
                Posts.parse_properties |
                Posts.ParseMarkdown).call(file)

debugger
    # data = {}
    #
    # data[:posts] = Dir['app/posts/*'].map do |file|
    #   # results = Services::Posts::OpenFile.call(file: file)
    #   # results = Services::Posts::ParseProperties.call( contents: results )
    #
    #   results = (Services::Posts::OpenFile     |
    #    Services::Posts::ParseProperties        |
    #    Services::Posts::ParseMarkdown          #|
    #    #Services::HashToOpenStruct
    #   ).call(file)
    #
    #   puts results
    #
    # end

    # # Generate post content
    # data[:posts] = Dir['app/posts/*'].map do |file|
    #   (Services::Posts::OpenFile        |
    #    Services::Posts::ParseProperties |
    #    Services::Posts::ParseMarkdown   |
    #    Services::HashToOpenStruct).call(file: file)
    # end
    #
    # # Generate template content for each template view file
    # data = Services::Each.new(Dir['app/views/*.slim'],
    #                           Services::Site::ProcessTemplate).call data
    #
    # # Process index page
    # data = Services::Site::ProcessStructurePage.call data
    #
    # # process post pages
    # data = Services::Each.new(data[:posts],
    #                           Services::Site::ProcessPostPage).call data
    #
    # debugger
    #
    # # Generate site files
    # #(Services::Site::GeneratePostPages |
    # # Services::Site::GenerateStructure |
    # # Services::Site::WriteFiles).call(posts: posts)
    #
    # options
  end
end
