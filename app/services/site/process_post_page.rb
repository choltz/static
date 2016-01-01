Namespace.build('Services::Site::ProcessPostPage') do
  include Services::Base

  # Public: Given a post object, process the content into a layout template
  #
  # options - parameter hash
  #   layout: symbol of the layout to process (default: :application)
  #   page:   page content to render. This value must be a key in the options
  #           hash
  #
  # Returns: parameter hash
  #   results: contains a string of the processed page
  def call(options = {})
    options = {
      layout:   :application
    }.update(options)

    options.tap do |opts|
      opts[:key]     = opts[:item].file.gsub(/^.+\//, '').gsub(/\..+/, '').gsub('-', '_')
      opts[:content] = opts[:item].html
      opts[:item]    = "app/views/layouts/#{opts[:layout]}.slim"

      opts = Services::Site::ProcessTemplate.call opts
    end
  end
end
