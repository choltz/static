Namespace.build('Services::Site::ProcessTemplate') do
  include Services::Base

  # Public: Given a list of site files, process them through slim to get html
  # output
  #
  # options - parameter hash
  #
  # Returns: parameter hash - file name as added as a key to the hash
  #          with the processed template as the key's value.
  def call(options = {})
    options.tap do |opts|
      key       = opts[:key] ||
                  opts[:item].gsub(/^.+\//, '') # extract the file name
                             .gsub(/\..+/, '')  # remove the extension
                             .gsub(/^_/, '')    # remove the leading underscore
                             .to_sym
      opts[key] = Slim::Template.new(opts[:item]).render(Object.new, options)
    end
  end
end
