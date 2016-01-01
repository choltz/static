Namespace.build('Services::Site::ProcessStructurePage') do
  include Services::Base

  # Public: Given a layout template and content to inject into it, process into
  # html.
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
      layout: :application,
      page:   :index
    }.update(options)

    options.tap do |opts|
      opts[:item]    = "app/views/layouts/#{opts[:layout]}.slim"
      opts[:key]     = opts[:page]
      opts[:content] = opts[opts[:key]]
      Services::Site::ProcessTemplate.call opts
    end
  end
end
