Namespace.build('Services::Builder::Build') do
  include Services::Base

  # Public: Build a static website from the temlates in app/views and the
  # posts in app/posts
  def call
    Slim::Engine.default_options[:disable_escape] = true

    data = {}

    # Generate post content
    data[:posts] = Dir['app/posts/*'].map do |file|
      (Services::Posts::OpenFile        |
       Services::Posts::ParseProperties |
       Services::Posts::ParseMarkdown   |
       Services::HashToOpenStruct).call(file: file)
    end

    # Generate template content for each template view file
    data = Services::Each.new(Dir['app/views/*.slim'],
                              Services::Site::ProcessTemplate).call data

    # Process index page
    data = Services::Site::ProcessStructurePage.call data

    # process post pages
    data = Services::Each.new(data[:posts],
                              Services::Site::ProcessPostPage).call data

    debugger

      # post list
      #
      # site map?


    posts.each do |post|
      #generate page
      # write to file
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
