Namespace.build('Services::Posts::ParseMarkdown') do
  include Services::Base

  # Public: convert the given markdown to html
  #
  # options - parameter hash
  #   contents: text that contains markdown
  #
  # Returns: parameter hash
  #   html: parsed markdown
  def call(contents)
    renderer = Redcarpet::Render::HTML.new
    parser   = Redcarpet::Markdown.new renderer
debugger
    markdown = contents.gsub(/---.+?---/m, '')
    parser.render markdown
  end
end
