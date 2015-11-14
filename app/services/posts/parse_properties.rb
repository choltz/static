Namespace.build('Services::Posts::ParseProperties') do
  include Services::Base

  # Public: Given a block of text with properties in the header, parse out the
  # properties and return as a hash
  #
  # options - parameter hash
  #   properties: text block with properties
  #
  # Example:
  # text = "---
  # layout: post
  # title: " title "
  # ---
  # some content"
  #
  # Services::Posts::ParseProperties.call contents: text
  # => { properties: { layout: post, title: 'title'} }
  #
  # Returns: parameter hash
  #   properties - hash
  def call(options = {})
    options.tap do |opts|
      opts[:properties] = opts[:contents].split(/---\n/)[1] # extract properties block
                                         .split(/\n/)       # split the properties by line
                                         .map(&method(:split_by_key_and_value))
                                         .map(&method(:strip_quotes_and_space))
                                         .flatten

      opts[:properties] = Hash[*opts[:properties]]
    end
  end

  # Internal: split a string whose key and value are separated by a colon
  #
  # text - string to parse
  #
  # Notes: it would be much easier to simply split(':'), but this does not
  # play nice with dates that contain times with colon delimiters
  #
  # Returns: a regex match
  def split_by_key_and_value(text)
    text.match(/(^[^:]+):([^$]*)/)
  end

  # Internal: Given a regex match with a key and value, return an array of the
  # first match and the last match with leading/trailing spaces and quotes
  # removed
  #
  # match - regex match object that contains the key and value from a string
  #
  # Returns: Array of key and value with spaces and quotes stripped
  def strip_quotes_and_space(match)
    [match[1], match[2].strip.gsub(/^\"|\"$/, '')]
  end
end
