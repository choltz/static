Namespace.build('Services::Posts::ParseMarkdown') do
  include Services::Base

  # Public: covnert the given markdown to html
  #
  # options - parameter hash
  #   contents: text that contains markdown
  #
  # Returns: parameter hash
  #   html: parsed markdown
  def call(options = {})
    options.tap do |opts|
      renderer = Redcarpet::Render::HTML.new
      parser   = Redcarpet::Markdown.new renderer
      markdown = opts[:contents].gsub(/---.+?---/m, '')

      options[:html] = parser.render markdown
    end
  end
end
